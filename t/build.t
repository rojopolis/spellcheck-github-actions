use strict;
use warnings;
use Test::More;

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

done_testing();
