#!/usr/bin/env perl

use autodie;
use strict;
use warnings;

use Test::More;
use FindBin;
my $dir;
BEGIN { $dir = $FindBin::Bin . '/' };
use lib $dir;

my $module = 'YSTR';

plan tests => 12;

ok -e "${dir}${module}.pm", "Missing $module.pm"
    or BAIL_OUT "You need to create file: $module.pm";

eval "use $module";
ok !$@, "Cannot load $module"
    or BAIL_OUT "Cannot load $module; Does it compile? Does it end with 1;?";

# Check availability of our methods
can_ok $module, "new"
    or BAIL_OUT "Missing package $module; or missing sub new()";

can_ok $module, "get_minimal"
    or BAIL_OUT "Missing package $module; or missing sub get_minimal()";

can_ok $module, "get_powerplexy"
    or BAIL_OUT "Missing package $module; or missing sub get_powerplexy()";

can_ok $module, "get_yfiler"
    or BAIL_OUT "Missing package $module; or missing sub get_yfiler()";

can_ok $module, "get_powerplexy23"
    or BAIL_OUT "Missing package $module; or missing sub get_powerplexy23()";

can_ok $module, "get_yfilerplus"
    or BAIL_OUT "Missing package $module; or missing sub get_yfilerplus()";

can_ok $module, "get_maximal"
    or BAIL_OUT "Missing package $module; or missing sub get_maximal()";

can_ok $module, "get_ftdna"
    or BAIL_OUT "Missing package $module; or missing sub get_ftdna()";

# can_ok $module, "get_yfull"
#     or BAIL_OUT "Missing package $module; or missing sub get_yfull()";

# Check options
is $module->new( [ 1, 2, 3, 4, 5, 6, 7, 8 ] )->{ absent }, 0, "default absent value to 0";
is $module->new( [ 1, 2, 3, 4, 5, 6, 7, 8 ], { absent => "n/a" } )->{absent}, "n/a", "default absent value to n/a";
