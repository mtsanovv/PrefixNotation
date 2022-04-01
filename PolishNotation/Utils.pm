package PolishNotation::Utils;

use PolishNotation::OperatorPriorities qw($OPERATOR_PRIORITIES);

sub isOperator {
    my ($class, $char) = @_;
    my @operators = keys %{$OPERATOR_PRIORITIES};
    return 1 if grep(/\Q$char\E/, @operators);
    return 0;
}

sub removeWhitespaces {
    my ($class, $inputReference) = @_;
    ${$inputReference} =~ s/\s*//g;
    return 1;
}

sub isValidInput {
    my ($class, $input) = @_;
    return 0 if($input !~ /^[a-zA-Z0-9\^\+\/\*\-\%\(\)]+$/);
    return 1;
}

1;