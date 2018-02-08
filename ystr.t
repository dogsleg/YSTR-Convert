#!/usr/bin/env perl

use autodie;
use strict;
use warnings;

use Test::More;
use JSON::PP;
use FindBin;
my $dir;
BEGIN { $dir = $FindBin::Bin . '/' };
use lib $dir;

my $cases_file = "${dir}cases.json";
my $cases;
my $decoder = JSON::PP->new();

if (open my $fh, '<', $cases_file) {
    local $/ = undef;
    $cases = $decoder->decode( scalar <$fh> );
} else {
    die "Could not open '$cases_file' $!";
}

plan tests => 16 + @$cases;

my $module = 'YSTR';

ok -e "${dir}${module}.pm", "Missing $module.pm"
    or BAIL_OUT "You need to create file: $module.pm";

eval "use $module";
ok !$@, "Cannot load $module"
    or BAIL_OUT "Cannot load $module; Does it compile? Does it end with 1;?";

# Check availability of our methods
foreach my $sub (qw/ new get_minimal get_powerplexy get_yfiler get_powerplexy23 get_yfilerplus
                        get_maximal get_ftdna /) {
    can_ok $module, $sub
        or BAIL_OUT "Missing package $module; or missing sub $sub()";
}

# Check options
is $module->new( [ 1, 2, 3, 4, 5, 6, 7, 8 ] )->{ absent }, 0, "use 0 as absent value";
is $module->new( [ 1, 2, 3, 4, 5, 6, 7, 8 ], { absent => "n/a" } )->{ absent }, "n/a", "use n/a as absent value";

is $module->new( [ 1, 2, 3, 4, 5, 6, 7, 8 ] )->{ inline }, "-", "use '-' as inline value";
is $module->new( [ 1, 2, 3, 4, 5, 6, 7, 8 ], { inline => "/" } )->{ inline }, "/", "use '/' as inline value";

is $module->new( [ 1, 2, 3, 4, 5, 6, 7, 8 ] )->{ separator }, " ", "use ' ' as separator value";
is $module->new( [ 1, 2, 3, 4, 5, 6, 7, 8 ], { separator => ", " } )->{ separator }, ", ", "use ', ' as inline value";

# Check conversion
foreach my $c (@$cases) {
    my $sub = $c->{sub};
    my $input = [ split / /, $c->{input} ];
    my $object = $module->new($input);
    my $output = join ' ', $module->$sub;
    is $output, $c->{expected}, $c->{name};
}
