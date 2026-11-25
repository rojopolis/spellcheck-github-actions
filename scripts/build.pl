#!/usr/bin/env perl

use warnings;
use strict;
use v5.10.0;
use autodie qw(:all);   # Recommended more: defaults and system/exec.
use version;

sub validate_version_format {
    my ($version) = @_;
    if ($version !~ m/^\d+\.\d+\.\d+$/) {
        die "Usage build.pl <version> (expected major.minor.patch, e.g. 1.0.0)\n";
    }
    return $version;
}

sub major_version {
    my ($version) = @_;
    my ($major) = $version =~ /^(\d+)\./;
    return $major;
}

sub floating_tag_name {
    my ($version) = @_;
    return 'v' . major_version($version);
}

sub existing_release_tags {
    my (@tags) = @_;
    return grep { /^\d+\.\d+\.\d+$/ } @tags;
}

sub is_new_latest {
    my ($candidate, @existing_tags) = @_;
    my $candidate_v = version->parse($candidate);
    my $max_v = $candidate_v;
    foreach my $tag (@existing_tags) {
        my $v = version->parse($tag);
        $max_v = $v if $v > $max_v;
    }
    return $candidate_v == $max_v;
}

sub run_or_die {
    my ($cmd) = @_;
    say $cmd;
    # autodie's :all wraps the system() builtin and throws its own verbose,
    # stack-traced exception on a nonzero exit; CORE::system bypasses that
    # override so this sub's own exit/signal handling below actually runs
    # and produces the clear, single-line message callers test against.
    CORE::system($cmd);
    if ($? == -1) {
        die "Failed to execute '$cmd': $!\n";
    }
    elsif ($? & 127) {
        die sprintf("Command '%s' died with signal %d\n", $cmd, $? & 127);
    }
    elsif ($? >> 8 != 0) {
        die sprintf("Command '%s' failed with exit code %d\n", $cmd, $? >> 8);
    }
    return 1;
}

sub git_tag_exists_locally {
    my ($tag) = @_;
    my $out = qx{git tag --list $tag};
    return $out =~ /\S/ ? 1 : 0;
}

sub git_tag_exists_remotely {
    my ($tag, $remote) = @_;
    $remote //= 'origin';
    my $out = qx{git ls-remote --tags $remote $tag 2>/dev/null};
    return $out =~ /\S/ ? 1 : 0;
}

sub targets_for {
    my ($version, @all_tags) = @_;
    my @targets = ($version, floating_tag_name($version));
    push @targets, 'latest' if is_new_latest($version, existing_release_tags(@all_tags));
    return @targets;
}

sub main {
    my ($version) = @_;

    if (not $version) {
        die 'Usage build.pl <version>';
    }

    validate_version_format($version);

    if (not -f 'Dockerfile') {
        die 'No Dockerfile found';
    }

    if (not -e '/opt/homebrew/bin/gh') {
        die 'No gh found';
    }

    if (not -f 'action.yml') {
        die 'No action.yml found';
    }

    open my $fh, '<', 'action.yml';
    my $action_yml = do { local $/; <$fh> };
    if ($action_yml !~ m/docker:\/\/jonasbn\/github-action-spellcheck:$version/) {
        die "Version in action.yml does not match: $version";
    }
    close $fh;

    say "Building Docker images for version: $version";

    my @targets = qw(v0 latest);

    push @targets, $version;

    say 'Building Docker images for amd64 architecture';

    my $counter = 0;
    my $total = scalar @targets;

    foreach my $target (@targets) {
        say "Building $target ($counter/$total)";
        run_or_die "docker build --platform linux/amd64 --tag jonasbn/github-action-spellcheck:$target .";
        $counter++;
    }

    $counter = 0;

    say "Pushing Docker images to DockerHub";
    foreach my $target (@targets) {
        say "Pushing $target ($counter/$total)";
        run_or_die "docker push jonasbn/github-action-spellcheck:$target";
        $counter++;
    }

    # Updating the floating major-version tag (v0, v1, ...)
    my $floating_tag = floating_tag_name($version);

    if (git_tag_exists_locally($floating_tag)) {
        say "Deleting existing tag $floating_tag locally";
        run_or_die("git tag --delete $floating_tag");
    }

    if (git_tag_exists_remotely($floating_tag)) {
        say "Deleting existing tag $floating_tag remotely";
        run_or_die("git push --delete origin $floating_tag");
    }

    say "Tagging also as $floating_tag";
    run_or_die(qq{git tag --annotate $floating_tag --message "Tagging $floating_tag"});

    # Pushing tags
    say 'Pushing tags';
    say 'git push --tags';
    run_or_die 'git push --tags';

    # The tagging of the version number is a part of the release process, so not need
    # to create this tag separately
    say 'Creating release on GitHub with auto generated release notes and discussion';
    run_or_die "gh release create $version --discussion-category 'General' --generate-notes";

    exit 0;
}

main(@ARGV) unless caller;

1;
