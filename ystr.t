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

my @subs = qw/ new set_absent set_inline get_absent get_inline
               get_minimal_str get_powerplexy_str get_yfiler_str
               get_powerplexy23_str get_yfilerplus_str get_maximal_str
               get_ftdna_str /;

subtest 'general module testing' => sub {
    plan tests => 2 + @subs;

    # Check availability of out module
    ok -e "${dir}${module}.pm", "Availability of $module.pm"
        or BAIL_OUT "Module $module.pm cannot be accessed";

    # Check module loading
    eval "use $module";
    ok !$@, "Loading of $module"
        or BAIL_OUT "Cannot load $module";

    # Check availability of our methods
    foreach my $sub (@subs) {
        can_ok $module, $sub
            or BAIL_OUT "Missing package $module; or missing sub $sub()";
    }
};

subtest 'options testing' => sub {
    plan tests => 4;

    my $dumb_strs =  [ 1, 2, 3, 4, 5, 6, 7, 8 ];

    # Check absent option
    is $module->new( $dumb_strs )->get_absent, 0, "Use 0 as absent value";
    is $module->new( $dumb_strs, { absent => "n/a" } )->get_absent, "n/a", "Use n/a as absent value";

    # Check inline option
    is $module->new( $dumb_strs )->get_inline, "-", "Use '-' as inline value";
    is $module->new( $dumb_strs, { inline => "/" } )->get_inline, "/", "Use '/' as inline value";
};

subtest 'conversion testing' => sub {
    plan tests => scalar @$cases;

    # Check conversion
    foreach my $case ( @$cases ) {
        my $sub = $case->{ sub };
        my $input = [ split / /, $case->{ input } ];
        my $object = $module->new( $input );
        my $output = join ' ', $object->$sub;
        is $output, $case->{ expected }, $case->{ name };
    }
};
