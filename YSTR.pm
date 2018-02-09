package YSTR;

use autodie;
use strict;
use warnings;

# YHRD formats
{
    # Minimal, 8 STRs
    my @_yhrd_minimal = qw/ DYS19 DYS389I DYS389II DYS390 DYS391
                            DYS392 DYS393 DYS385 /;

    # PowerPlex Y, 11
    my @_yhrd_powerplex_y = qw/ DYS391 DYS389I DYS439 DYS389II DYS438
                                DYS437 DYS19 DYS392 DYS393 DYS390
                                DYS385 /;

    # Yfiler, 16 STRs
    my @_yhrd_yfiler = qw/ DYS456 DYS389I DYS390 DYS389II DYS458 DYS19
                           DYS385 DYS393 DYS391 DYS439 DYS635 DYS392
                           YGATAH4 DYS437 DYS438 DYS448 /;

    # PowerPlex Y23, 22 STRs
    my @_yhrd_powerplex_y23 = qw/ DYS576 DYS389I DYS448 DYS389II DYS19
                                 DYS391 DYS481 DYS549 DYS533 DYS438
                                 DYS437 DYS570 DYS635 DYS390 DYS439
                                 DYS392 DYS643 DYS393 DYS458 DYS385
                                 DYS456 YGATAH4 /;

    # Yfiler Plus, 25 STRs
    my @_yhrd_yfiler_plus = qw/ DYS576 DYS389I DYS635 DYS389II DYS627
                                DYS460 DYS458 DYS19 YGATAH4 DYS448
                                DYS391 DYS456 DYS390 DYS438 DYS392
                                DYS518 DYS570 DYS437 DYS385 DYS449
                                DYS393 DYS439 DYS481 DYF387S1 DYS533 /;

    # Maximal, 27 STRs
    my @_yhrd_maximal = ( @_yhrd_minimal, qw/ DYS438 DYS439 DYS437
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
}

sub new {
    my $class = shift;
    my ($data, $options) = @_;

    # Check that we got the correct number of STR values
    die "Wrong number of STRs!" unless (grep { $_ == scalar @$data } qw/ 8 11 16 22 25 27 102 /);

    my $absent = $options->{"absent"} // 0;
    my $inline = $options->{"inline"} // "-";
    my $separator = $options->{"separator"} // " ";

    bless { _data => $data, _absent => $absent, _inline => $inline, _separator => $separator }, $class;
}

sub set_absent {
    my ($self, $absent) = @_;
    $self->{ _absent }= $absent if $absent;
}

sub set_inline {
    my ($self, $inline) = @_;
    $self->{ _inline }= $inline if $inline;
}

sub set_separator {
    my ($self, $separator) = @_;
    $self->{ _separator }= $separator if $separator;
}

sub get_absent { $_[0]->{ _absent } }

sub get_inline { $_[0]->{ _inline } }

sub get_separator { $_[0]->{ _separator } }

sub get_minimal {
    return
}

sub get_powerplexy {
    return
}

sub get_yfiler {
    return
}

sub get_powerplexy23 {
    return
}

sub get_yfilerplus {
    return
}

sub get_maximal {
    return
}

sub get_ftdna {
    return
}

# sub get_yfull {
#     return
# }

1;
