use strict;
use warnings;
use Test::More;
use File::Temp qw(tempdir);
use Cwd qw(getcwd);

require './scripts/build.pl';

# validate_version_format
is(validate_version_format('1.0.0'), '1.0.0', 'accepts well-formed version');
eval { validate_version_format('1.0') };
like($@, qr/Usage/, 'rejects a version missing the patch component');
eval { validate_version_format('v1.0.0') };
like($@, qr/Usage/, 'rejects a version with a leading v');
eval { validate_version_format('1.0.0-rc1') };
like($@, qr/Usage/, 'rejects a pre-release suffix');

# major_version
is(major_version('1.0.0'), '1', 'major of 1.0.0 is 1');
is(major_version('0.71.0'), '0', 'major of 0.71.0 is 0');
is(major_version('12.3.4'), '12', 'major handles multi-digit numbers');

# floating_tag_name
is(floating_tag_name('1.0.0'), 'v1', 'floating tag for 1.x is v1');
is(floating_tag_name('0.9.1'), 'v0', 'floating tag for 0.x is v0');

# existing_release_tags
is_deeply(
    [ sort(existing_release_tags(qw(v0 v1 0.71.0 1.0.0 latest 0.9.1))) ],
    [ sort qw(0.71.0 1.0.0 0.9.1) ],
    'filters out floating and non-release tags'
);

# is_new_latest
ok(is_new_latest('1.0.0', qw(0.71.0 0.70.0)), '1.0.0 is new latest over 0.x history');
ok(!is_new_latest('0.72.0', qw(0.71.0 1.0.0)), 'a 0.x backport after 1.0.0 is not latest');
ok(is_new_latest('0.71.0', qw(0.70.0 0.69.0)), 'first release in isolation is latest');
ok(!is_new_latest('0.70.0', qw(0.71.0 1.0.0)), 'releasing an older version string is never latest');
ok(is_new_latest('0.71.0', qw(0.71.0)), 're-releasing the current latest version keeps it latest');
ok(!is_new_latest('1.5.0', qw(0.71.0 1.4.0 2.0.0)), 'a mid-major backport released after a newer major is not latest');
ok(is_new_latest('2.1.0', qw(0.71.0 1.4.0 2.0.0)), 'a genuinely newer release across three majors is latest');

# targets_for
is_deeply(
    [ targets_for('1.0.0', qw(0.71.0 0.70.0 v0)) ],
    [ '1.0.0', 'v1', 'latest' ],
    'first 1.x release targets itself, v1, and latest'
);
is_deeply(
    [ targets_for('0.72.0', qw(0.71.0 1.0.0 v0 v1)) ],
    [ '0.72.0', 'v0' ],
    'a 0.x backport after 1.0.0 targets itself and v0 only, never latest'
);

# run_or_die
is(run_or_die('true'), 1, 'run_or_die returns true on success');

eval { run_or_die('sh -c "exit 42"') };
like($@, qr/exit code 42/, 'run_or_die reports the exact nonzero exit code');

eval { run_or_die('false') };
like($@, qr/exit code 1/, 'run_or_die dies on a plain failing command');

eval { run_or_die('kill -TERM $$') };
like($@, qr/signal/, 'run_or_die reports death by signal distinctly from a nonzero exit');

# git_tag_exists_locally / git_tag_exists_remotely
{
    my $orig_cwd = getcwd();
    my $remote_dir = tempdir(CLEANUP => 1);
    my $work_dir   = tempdir(CLEANUP => 1);

    system("git init --quiet --bare $remote_dir");
    system("git -C $work_dir init --quiet");
    system("git -C $work_dir config user.email test\@example.com");
    system("git -C $work_dir config user.name Test");
    system("git -C $work_dir commit --quiet --allow-empty -m init");
    system("git -C $work_dir remote add origin $remote_dir");
    system("git -C $work_dir tag v0");
    system("git -C $work_dir push --quiet origin v0");

    chdir $work_dir or die $!;

    ok(git_tag_exists_locally('v0'), 'v0 exists locally after tagging');
    ok(!git_tag_exists_locally('v9'), 'v9 does not exist locally');
    ok(git_tag_exists_remotely('v0', 'origin'), 'v0 exists on the fake origin after pushing');
    ok(!git_tag_exists_remotely('v9', 'origin'), 'v9 does not exist on the fake origin');

    chdir $orig_cwd or die $!;
}

# dockerhub_login_configured
{
    my $dir = tempdir(CLEANUP => 1);

    my $missing = "$dir/missing-config.json";
    ok(!dockerhub_login_configured($missing), 'no config file means not configured');

    my $empty_path = "$dir/empty.json";
    open my $fh1, '>', $empty_path or die $!;
    print {$fh1} '{}';
    close $fh1;
    ok(!dockerhub_login_configured($empty_path), 'empty config means not configured');

    my $creds_store_path = "$dir/credstore.json";
    open my $fh2, '>', $creds_store_path or die $!;
    print {$fh2} '{"credsStore":"desktop"}';
    close $fh2;
    ok(dockerhub_login_configured($creds_store_path), 'a credsStore entry counts as configured');

    my $explicit_auth_path = "$dir/explicit.json";
    open my $fh3, '>', $explicit_auth_path or die $!;
    print {$fh3} '{"auths":{"https://index.docker.io/v1/":{"auth":"x"}}}';
    close $fh3;
    ok(dockerhub_login_configured($explicit_auth_path), 'an explicit docker.io auth entry counts as configured');
}

done_testing();
