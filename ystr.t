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

if ( open my $fh, '<', $cases_file ) {
    local $/ = undef;
    $cases = $decoder->decode( scalar <$fh> );
} else {
    die "Could not open '$cases_file' $!";
}

plan tests => 3;

my $module = 'YSTR';

my @subs = qw/ new set_absent set_inline set_separator get_absent
               get_inline get_separator get_minimal get_powerplexy
               get_yfiler get_powerplexy23 get_yfilerplus get_maximal
               get_ftdna /;

subtest 'general module testing' => sub {
    plan tests => 2 + @subs;

    # Check availability of out module
    ok -e "${dir}${module}.pm", "Missing $module.pm"
        or BAIL_OUT "You need to create file: $module.pm";

    # Check module loading
    eval "use $module";
    ok !$@, "Cannot load $module"
        or BAIL_OUT "Cannot load $module; Does it compile? Does it end with 1;?";

    # Check availability of our methods
    foreach my $sub (@subs) {
        can_ok $module, $sub
            or BAIL_OUT "Missing package $module; or missing sub $sub()";
    }
};

subtest 'options testing' => sub {
    plan tests => 6;

    my $dumb_strs =  [ 1, 2, 3, 4, 5, 6, 7, 8 ];

    # Check absent option
    is $module->new( $dumb_strs )->get_absent, 0, "use 0 as absent value";
    is $module->new( $dumb_strs, { absent => "n/a" } )->get_absent, "n/a", "use n/a as absent value";

    # Check inline option
    is $module->new( $dumb_strs )->get_inline, "-", "use '-' as inline value";
    is $module->new( $dumb_strs, { inline => "/" } )->get_inline, "/", "use '/' as inline value";

    # Check separator option
    is $module->new( $dumb_strs )->get_separator, " ", "use ' ' as separator value";
    is $module->new( $dumb_strs, { separator => ", " } )->get_separator, ", ", "use ', ' as inline value";
};

subtest 'conversion testing' => sub {
    plan tests => scalar @$cases;

    # Check conversion
    foreach my $case ( @$cases ) {
        my $sub = $case->{ sub };
        my $input = [ split / /, $case->{ input } ];
        my $object = $module->new( $input );
        my $output = join ' ', $module->$sub;
        is $output, $case->{ expected }, $case->{ name };
    }
};
