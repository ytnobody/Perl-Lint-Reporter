use strict;

use Test::More;
use Test::Differences;
use Capture::Tiny ':all';

use Perl::Lint qw/lint/;
use Perl::Lint::Reporter;

subtest 'violation' => sub {
    my $expect = <<EOS;
\e[31m6 violations found
\e[0m\e[35m## t/data/violation.pl \e[0m\e[34m(6 violations)
\e[0m  * [line 0] No package-scoped "\$VERSION" variable found \e[33m(Perl::Lint::Policy::Modules::RequireVersionVar)\e[0m
  * [line 1] Code not contained in explicit package \e[33m(Perl::Lint::Policy::Modules::RequireExplicitPackage)\e[0m
  * [line 1] Code before strictures are enabled \e[33m(Perl::Lint::Policy::TestingAndDebugging::RequireUseStrict)\e[0m
  * [line 1] Code before warnings are enabled \e[33m(Perl::Lint::Policy::TestingAndDebugging::RequireUseWarnings)\e[0m
  * [line 1] Mixed high and low-precedence booleans \e[33m(Perl::Lint::Policy::ValuesAndExpressions::ProhibitMixedBooleanOperators)\e[0m
  * [line 3] Module does not end with "1;" \e[33m(Perl::Lint::Policy::Modules::RequireEndWithOne)\e[0m
EOS

    my $violations = lint(['t/data/violation.pl']);
    my $stdout = capture_stdout { report_violations($violations) };

    eq_or_diff $stdout, $expect, 'violation report';
};

subtest 'cleanse' => sub {
    my $stdout = capture_stdout { report_violations([]) };
    my $expect = <<EOS;
\e[36mYay! no violations found!\e[0m
EOS
    eq_or_diff $stdout, $expect, 'cleanse';
};

done_testing;
