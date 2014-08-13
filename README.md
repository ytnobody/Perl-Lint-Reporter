# NAME

Perl::Lint::Reporter - Output report from violations value of Perl::Lint

# SYNOPSIS

    use Perl::Lint qw/lint/;
    use Perl::Lint::Reporter;
    
    my $violations = lint(['path/to/script.pl', 'path/to/other/script.pl']);
    report_violations($violations);

# DESCRIPTION

Perl::Lint::Reporter is a report formatter for violation value of Perl::Lint.

# EXAMPLE IMAGE

<div>
    <img src="http://i.gyazo.com/23068bb9942ff9a9700f0bcc6fb14cfb.png">
</div>

# EXPORT

## report\_violations($violations)

Print a report about violations that is result of analysing by Perl::Lint.

# LICENSE

Copyright (C) ytnobody.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

ytnobody <ytnobody@gmail.com>
