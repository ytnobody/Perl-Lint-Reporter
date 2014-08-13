package Perl::Lint::Reporter;
use strict;
use warnings;
use 5.008001;
use parent 'Exporter';
use Term::ANSIColor;

our $VERSION = 0.01;
our @EXPORT = qw/report_violations/;

sub report_violations {
    my ($violations) = @_;

    if (my $count = scalar(@{$violations})) {
        printf colored("%s violations found\n" => 'red') => $count;

        my $filename = '';
        for my $violation (sort {$a->{filename} cmp $b->{filename}} sort {$a->{line} <=> $b->{line}} @{$violations}) {

            if ($filename ne $violation->{filename}) {
                $filename = $violation->{filename};
                my $co_count = scalar(grep {$_->{filename} eq $filename} @{$violations});
                printf colored("## %s " => 'magenta') => $filename;
                printf colored("(%s violations)\n" => 'blue') => $co_count;
            }

            printf "  * [line %s] %s " => $violation->{line}, $violation->{description} || 'a something violation found';
            printf colored("(%s)" => 'yellow') => $violation->{policy};
            print "\n";
        }

        return 1;
    }
    else {
        printf colored("Yay! no violations found!" => 'cyan')."\n";
        return 0;
    }
}

1;
__END__

=encoding utf-8

=head1 NAME

Perl::Lint::Reporter - It's new $module

=head1 SYNOPSIS

    use Perl::Lint::Reporter;

=head1 DESCRIPTION

Perl::Lint::Reporter is ...

=head1 LICENSE

Copyright (C) ytnobody.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

ytnobody E<lt>ytnobody@gmail.comE<gt>

=cut

