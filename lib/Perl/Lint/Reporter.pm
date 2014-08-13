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

Perl::Lint::Reporter - Output report from violations value of Perl::Lint

=head1 SYNOPSIS

    use Perl::Lint qw/lint/;
    use Perl::Lint::Reporter;
    
    my $violations = lint(['path/to/script.pl', 'path/to/other/script.pl']);
    report_violations($violations);

=head1 DESCRIPTION

Perl::Lint::Reporter is a report formatter for violation value of Perl::Lint.

=head1 EXAMPLE IMAGE

=begin html

<img src="http://i.gyazo.com/23068bb9942ff9a9700f0bcc6fb14cfb.png">

=end html

=head1 EXPORT

=head2 report_violations($violations)

Print a report about violations that is result of analysing by Perl::Lint.

=head1 LICENSE

Copyright (C) ytnobody.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

ytnobody E<lt>ytnobody@gmail.comE<gt>

=cut

