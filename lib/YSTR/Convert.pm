package YSTR::Convert;

use autodie;
use strict;
use warnings;

our $VERSION = '0.01';

# Supported formats
{
    # Minimal, 8 STRs
    my @_minimal = qw/ DYS19 DYS389I DYS389II DYS390 DYS391
                            DYS392 DYS393 DYS385 /;

    # PowerPlex Y, 11 STRs
    my @_powerplex_y = qw/ DYS391 DYS389I DYS439 DYS389II DYS438
                                DYS437 DYS19 DYS392 DYS393 DYS390
                                DYS385 /;

    # Yfiler, 16 STRs
    my @_yfiler = qw/ DYS456 DYS389I DYS390 DYS389II DYS458 DYS19
                           DYS385 DYS393 DYS391 DYS439 DYS635 DYS392
                           YGATAH4 DYS437 DYS438 DYS448 /;

    # PowerPlex Y23, 22 STRs
    my @_powerplex_y23 = qw/ DYS576 DYS389I DYS448 DYS389II DYS19
                                 DYS391 DYS481 DYS549 DYS533 DYS438
                                 DYS437 DYS570 DYS635 DYS390 DYS439
                                 DYS392 DYS643 DYS393 DYS458 DYS385
                                 DYS456 YGATAH4 /;

    # Yfiler Plus, 25 STRs
    my @_yfiler_plus = qw/ DYS576 DYS389I DYS635 DYS389II DYS627
                                DYS460 DYS458 DYS19 YGATAH4 DYS448
                                DYS391 DYS456 DYS390 DYS438 DYS392
                                DYS518 DYS570 DYS437 DYS385 DYS449
                                DYS393 DYS439 DYS481 DYF387S1 DYS533 /;

    # Maximal, 27 STRs
    my @_maximal = ( @_minimal, qw/ DYS438 DYS439 DYS437
                                              DYS448 DYS456 DYS458
                                              DYS635 YGATAH4 DYS481
                                              DYS533 DYS549 DYS570
                                              DYS576 DYS643 DYF387S1
                                              DYS449 DYS460 DYS518
                                              DYS627 / );

    # FTDNA, 102 STRs
    my @_ftdna = qw/ DYS393 DYS390 DYS19 DYS391 DYS385 DYS426 DYS388
                     DYS439 DYS389I DYS392 DYS389II DYS458 DYS459
                     DYS455 DYS454 DYS447 DYS437 DYS448 DYS449 DYS464
                     DYS460 Y-GATA-H4 YCAII DYS456 DYS607 DYS576 DYS570
                     CDY DYS442 DYS438 DYS531 DYS578 DYF395S1 DYS590
                     DYS537 DYS641 DYS472 DYF406S1 DYS511 DYS425 DYS413
                     DYS557 DYS594 DYS436 DYS490 DYS534 DYS450 DYS444
                     DYS481 DYS520 DYS446 DYS617 DYS568 DYS487 DYS572
                     DYS640 DYS492 DYS565 DYS710 DYS485 DYS632 DYS495
                     DYS540 DYS714 DYS716 DYS717 DYS505 DYS556 DYS549
                     DYS589 DYS522 DYS494 DYS533 DYS636 DYS575 DYS638
                     DYS462 DYS452 DYS445 Y-GATA-A10 DYS463 DYS441
                     Y-GGAAT-1B07 DYS525 DYS712 DYS593 DYS650 DYS532
                     DYS715 DYS504 DYS513 DYS561 DYS552 DYS726 DYS635
                     DYS587 DYS643 DYS497 DYS510 DYS434 DYS461 DYS435 /;

    # TODO: FTDNA Y500, 552 STRs
    my @_ftdna_y500 = ( @_ftdna, qw / FTY371 FTY303 FTY10 FTY284
                                      FTY219 FTY324 FTY327 FTY394
                                      DYS538 FTY220 FTY254 FTY19 FTY4
                                      DYS577 FTY24 FTY346 FTY160 FTY62
                                      FTY400 FTY114 FTY246 FTY26
                                      FTY368 FTY173 FTY209 FTY337
                                      FTY81 FTY387 FTY361 FTY330 FTY65
                                      FTY168 FTY171 FTY136 FTY53 FTY40
                                      FTY386 FTY100 FTY152 FTY55
                                      FTY297 FTY370 FTY103 FTY64
                                      FTY174 FTY313 FTY362 FTY342
                                      FTY161 FTY374 FTY316 FTY101
                                      FTY204 DYS477 FTY192 DYS502
                                      FTY341 DYS493 FTY1 FTY227 DYS499
                                      FTY391 FTY353 FTY332 FTY163
                                      DYS483 FTY172 FTY180 DYS581
                                      FTY179 FTY188 FTY369 FTY70 FTY63
                                      DYS508 FTY347 FTY83 FTY277
                                      FTY276 FTY195 FTY109 FTY356
                                      FTY215 FTY105 FTY123 FTY242
                                      FTY214 FTY132 FTY262 FTY333
                                      FTY208 DYF398B FTY43 FTY166
                                      FTY13 FTY11 DYS584 DYS608 FTY95
                                      FTY151 FTY388 FTY256 DYS580
                                      FTY234 FTY268 FTY139 FTY27 FTY75
                                      DYS512 FTY329 FTY320 FTY7 FTY247
                                      FTY211 DYS474 FTY39 FTY376 FTY37
                                      FTY373 DYS475 FTY138 FTY288
                                      FTY264 FTY93 FTY380 FTY18 FTY115
                                      DYS569 FTY390 FTY46 FTY243
                                      FTY322 FTY281 FTY153 FTY181
                                      FTY184 FTY359 FTY121 FTY74
                                      FTY279 DYS530 FTY45 DYS573
                                      DYS542 FTY36 FTY304 FTY203
                                      FTY291 FTY142 FTY191 FTY183
                                      FTY141 FTY299 FTY193 FTY124
                                      FTY16 FTY236 FTY185 FTY378
                                      FTY225 FTY397 FTY3 FTY67 FTY182
                                      FTY334 DYS623 FTY348 FTY357
                                      FTY275 FTY306 FTY383 FTY253
                                      FTY285 DYS645 FTY17 FTY85 DYS598
                                      FTY375 FTY325 FTY12 FTY365 FTY35
                                      FTY237 FTY238 FTY305 FTY56
                                      FTY129 FTY352 FTY292 FTY154
                                      DYS539 FTY301 FTY366 FTY231
                                      DYS618 FTY216 FTY82 FTY393
                                      FTY155 FTY68 FTY32 FTY265 FTY300
                                      FTY143 FTY201 FTY199 FTY86 FTY98
                                      FTY144 DYS541 DYS507 FTY20
                                      FTY116 FTY308 FTY177 FTY89
                                      FTY158 FTY22 FTY84 FTY186 FTY396
                                      FTY91 FTY29 FTY78 FTY229 FTY260
                                      FTY250 FTY364 DYS476 FTY221
                                      FTY57 FTY377 FTY384 DYS466
                                      FTY363 FTY137 FTY69 FTY72 FTY251
                                      FTY2 FTY217 FTY257 FTY120 FTY25
                                      FTY252 FTY33 FTY42 FTY54 FTY372
                                      DYS480 FTY176 FTY76 FTY66 FTY197
                                      FTY385 FTY270 FTY298 FTY198
                                      FTY117 DYS544 FTY159 FTY232
                                      FTY156 FTY343 FTY296 FTY311
                                      FTY344 FTY178 FTY367 FTY73
                                      FTY112 FTY295 DYS616 FTY338
                                      FTY196 FTY157 FTY162 DYS551
                                      FTY148 FTY94 FTY52 FTY131 FTY9
                                      FTY194 FTY8 FTY318 FTY317 FTY99
                                      FTY289 FTY169 FTY51 FTY345
                                      FTY398 FTY111 FTY273 FTY382
                                      FTY47 FTY30 FTY147 DYS615 FTY302
                                      FTY354 FTY326 FTY88 FTY248
                                      FTY267 FTY170 FTY60 DYS453
                                      FTY249 FTY167 DYS624 FTY134
                                      FTY235 FTY145 FTY14 FTY80 FTY50
                                      DYS514 FTY340 DYS585 DYS516
                                      FTY293 FTY207 FTY278 FTY210
                                      DYS523 FTY269 FTY530 FTY1156
                                      FTY1070 FTY906 FTY1004 FTY331
                                      FTY31 FTY226 FTY335 DYS583
                                      FTY339 FTY113 FTY280 FTY255
                                      FTY59 DYS620 FTY349 FTY130
                                      FTY119 DYF398A FTY58 FTY127
                                      FTY321 FTY92 FTY392 DYF392
                                      FTY290 FTY312 FTY135 FTY150
                                      FTY294 FTY244 FTY48 FTY282
                                      DYS489 FTY272 FTY239 FTY258
                                      FTY49 DYS574 FTY41 FTY905
                                      FTY1103 FTY502 FTY743 FTY443
                                      FTY670 FTY883 DYS631 FTY1042
                                      FTY510 DYS389B FTY512 FTY837
                                      DYS642 FTY407 FTY935 FTY563
                                      FTY1016 FTY1091 FTY1049 FTY1155
                                      DYS602 FTY587 FTY635 FTY904
                                      DYS543 FTY1148 FTY861 FTY742
                                      FTY433 FTY1039 FTY71 FTY259
                                      FTY108 FTY336 FTY44 FTY233
                                      FTY274 FTY34 FTY942 FTY1068
                                      FTY945 FTY1051 FTY658 FTY625
                                      FTY800 FTY818 FTY971 FTY509
                                      FTY1025 FTY835 FTY984 DYS637
                                      FTY832 FTY689 FTY998 FTY520
                                      FTY445 FTY809 FTY428 FTY562
                                      FTY897 FTY1064 FTY1088 FTY1052
                                      DYF405 FTY310 FTY189 DYS488
                                      FTY283 FTY28 FTY578 DYS484
                                      FTY858 FTY596 FTY915 FTY446
                                      FTY452 FTY1006 FTY612 FTY507 / );

    # TODO: YFull STRs
    my @_yfull = qw/ /;

    my %_formats = ( minimal       => \@_minimal,
                     powerplex_y   => \@_powerplex_y,
                     yfiler        => \@_yfiler,
                     powerplex_y23 => \@_powerplex_y23,
                     yfiler_plus   => \@_yfiler_plus,
                     maximal       => \@_maximal,
                     ftdna         => \@_ftdna,
                     ftdna_y500    => \@_ftdna_y500 );

    my $_get_format = sub {
        return $_formats{$_[0]} if ( exists $_formats{$_[0]} );
        die "ERROR: Requested unknown format" };

    sub get_minimal_format { $_get_format->("minimal") }

    sub get_powerplexy_format { $_get_format->("powerplex_y")}

    sub get_yfiler_format { $_get_format->("yfiler")}

    sub get_powerplexy23_format { $_get_format->("powerplex_y23")}

    sub get_yfilerplus_format { $_get_format->("yfiler_plus")}

    sub get_maximal_format { $_get_format->("maximal")}

    sub get_ftdna_format { $_get_format->("ftdna")}

    sub get_ftdnay500_format { $_get_format->("ftdna_y500")}

}

sub new {
    my $class = shift;
    my ($data, $options) = @_;

    # Check that we got the correct number of STR values
    die "ERROR: No STRs specified" unless (defined $data);
    die "ERROR: Wrong number of STRs" unless (grep { $_ == scalar @$data } qw/ 8 11 16 22 25 27 102 552 /);

    sub guess_format {
        my $len = scalar @{ shift @_ };
        if ($len == 8) {
            return get_minimal_format()
        } elsif ($len == 11) {
            return get_powerplexy_format()
        } elsif ($len == 16) {
            return get_yfiler_format()
        } elsif ($len == 22) {
            return get_powerplexy23_format()
        } elsif ($len == 25) {
            return get_yfilerplus_format()
        } elsif ($len == 27) {
            return get_maximal_format()
        } elsif ($len == 102) {
            return get_ftdna_format()
        } elsif ($len == 552) {
            return get_ftdnay500_format()
        }
    }

    my @format = @{guess_format($data)};
    my $absent = $options->{"absent"} // 0;
    my $inline = $options->{"inline"} // "-";

    bless { _data   => $data,
            _format => \@format,
            _absent => $absent,
            _inline => $inline }, $class;
}

sub set_absent {
    my ($self, $absent) = @_;
    $self->{ _absent }= $absent if $absent;
}

sub set_inline {
    my ($self, $inline) = @_;
    $self->{ _inline }= $inline if $inline;
}

sub get_absent { $_[0]->{ _absent } }

sub get_inline { $_[0]->{ _inline } }

sub _convert {
    my ( $self, $output_format ) = @_;

    my @formatted;

    foreach my $o_str ( @{$output_format} ) {
        my $got_matched = 0;
        my $length      = @formatted;

        # Remove dash ("-") from STR name
        $o_str =~ s/-//gx;

        # Dirty hack to handle "." in YFull STR names, use "S" instead
        # $_ =~ s/\./S/g;

        while ( my ( $index, $i_str ) = each @{$self->{ _format }}) {

            $got_matched = 0;

            # Dirty hacks once more
            $i_str =~ s/-//gx;

            # $str =~ s/\./S/g;

            if ( $i_str =~ m/$o_str\z/x ) {
                if ($got_matched) {
                    $formatted[-1] .= $self->{ _inline } . $self->{ _data }[$index];
                }
                else {
                    $got_matched = 1;
                    if ( $self->{ _data }[$index] =~ m/-/x ) {
                        my $new = $self->{ _data }[$index];
                        $new =~ s/-/$self->{ _inline }/gx;
                        push @formatted, $new;
                    }
                    else {
                        push @formatted, $self->{ _data }[$index];
                    }
                }
            }
        }

        if ( $length == @formatted ) {
            push @formatted, $self->{ _absent };
        }

        $length      = @formatted;
        $got_matched = 0;
    }
    return @formatted;
}

sub get_minimal_str {
    my $self = shift;
    $self->_convert(get_minimal_format())
}

sub get_powerplexy_str {
    my $self = shift;
    $self->_convert(get_powerplexy_format())
}

sub get_yfiler_str {
    my $self = shift;
    $self->_convert(get_yfiler_format())
}

sub get_powerplexy23_str {
    my $self = shift;
    $self->_convert(get_powerplexy23_format())
}

sub get_yfilerplus_str {
    my $self = shift;
    $self->_convert(get_yfilerplus_format())
}

sub get_maximal_str {
    my $self = shift;
    $self->_convert(get_maximal_format())
}

sub get_ftdna_str {
    my $self = shift;
    $self->_convert(get_ftdna_format())
}

# TODO: Properly implement the following getters

# sub get_ftdnay500_str {
#     my $self = shift;
#     self->_convert(get_ftdnay500_format())
# }

# sub get_yfull {
#     return
# }

1;

__END__

=head1 NAME

YSTR::Convert - Convert STR data between various STR formats

=head1 SYNOPSIS

  package MySTR;
  use YSTR::Convert;

  # create a new object, passing your original STR data,
  # [ 1, 2, 3, 4, 5, 6, 7, 8 ] as the first argument,
  # and a hash, containing absent and inline values as
  # the second argument
  my $str_data = YSTR::Convert->new( [ 1, 2, 3, 4, 5, 6, 7, 8 ],
                                    { absent => 0,
                                      inline => " " } );

  # print your original STR data converted to Maximal format
  print $str_data->get_maximal_str();

=head1 DESCRIPTION

YSTR::Convert provides object-oriented way to convert your Y-DNA STR
data between various STR formats. Currently it supports the following
formats:

=over

=item * Minimal, 8 STRs, C<get_minimal_str()> method

=item * PowerPlex Y, 11 STRs, C<get_powerplexy_str()> method

=item * Yfiler, 16 STRs, C<get_yfiler_str()> method

=item * PowerPlex Y23, 22 STRs, C<get_powerplexy23_str()> method

=item * Yfiler Plus, 25 STRs, C<get_yfilerplus_str()> method

=item * Maximal, 27 STRs, C<get_maximal_str()> method

=item * FTDNA, 102 STRs, C<get_ftdna_str()> method

=back

To convert Y-DNA STR data one needs to instantiate an objects, passing
one's original STR data in form of an array as the first argument and
(optionally) a hash with configuration options as the second argument.
Configuration options C<absent> and C<inline> are supported. The value
of the C<absent> option will be used as a value for STR which are
absent from one's original STR data, by default the value of C<absent>
is 0. The value of C<inline> option will be used as an inline
separator in some multi-valued complex STRs (e. g., DYS385).

In case your original data in one of the supported format lacks some
STR values, use 0, "n/a", or any other value for them, which will help
you easily distinguish them from other STR values. It is recommended
to set the C<absent> option to the value chosen for such absent STR
values in your original STR data.

Configuration options can be viewed or changed after the instantiation
with the help of their getters and setters: C<get_absent()>,
C<set_absent()>, C<get_inline()>, and C<set_inline()>.

All the supported STR formats are defined as the class data, one can
access them by means of their corresponding class accessors:
C<get_minimal_format()>, C<get_powerplexy_format()>,
C<get_yfiler_format()>, C<get_powerplexy23_format()>,
C<get_yfilerplus_format()>, C<get_maximal_format()>,
C<get_ftdna_format()>.

=head1 AUTHOR

Lev Lamberov E<lt>dogsleg@riseup.netE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2018 by Lev Lamberov

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.26.1 or,
at your option, any later version of Perl 5 you may have available.

=cut
