package PolishNotation::PrefixConverter;

use PolishNotation::OperatorPriorities qw($OPERATOR_PRIORITIES);

sub new {
    my ($class, $input) = @_;
    my $self = {
        input => $input
    };
    bless $self, $class;
}

sub convertToPrefix {
    my ($self) = @_;
    my @allCharsInInput = split '', $self->{input};
    my $operatorsStack = [];
    my $prefixOutput = '';

    foreach my $char (@allCharsInInput) {
        if(!PolishNotation::Utils->isOperator($char)) {
            $prefixOutput .= $char;
            next;
        }

        $self->processOperator($char, $operatorsStack, \$prefixOutput);
    }
    $self->pullAllOperatorsFromStackTo($operatorsStack, \$prefixOutput);
    return reverse $prefixOutput;
}

sub processOperator {
    my ($self, $operator, $operatorsStack, $prefixOutputReference) = @_;
    my $operatorStackPriority = $self->getOperatorStackPriority($operator);

    $self->popStackIfNeededToMatchPriority($operator, $operatorsStack, $prefixOutputReference);
    push @{$operatorsStack}, $operator if defined $operatorStackPriority; # operator without a defined stack priority cannot be a part of the stack
    return 1;
}

sub popStackIfNeededToMatchPriority {
    my ($self, $operator, $operatorsStack, $prefixOutputReference) = @_;
    my $operatorEntryPriority = $self->getOperatorEntryPriority($operator);
    my $lastOperatorInStackPriority = $self->getOperatorStackPriority($operatorsStack->[-1]);
    $lastOperatorInStackPriority = -1 if(!defined $lastOperatorInStackPriority);

    if($lastOperatorInStackPriority > $operatorEntryPriority) {
        my $poppedOperator = pop @{$operatorsStack};
        ${$prefixOutputReference} .= $poppedOperator if $poppedOperator !~ /\(|\)/;
        return 1 if $operator eq '(' && $poppedOperator eq ')'; # do not overpop brackets, one opening bracket can only pop only one closing bracket
        $self->popStackIfNeededToMatchPriority($operator, $operatorsStack, $prefixOutputReference);
    }
    return 1;
}

sub pullAllOperatorsFromStackTo {
    my  ($self, $operatorsStack, $prefixOutputReference) = @_;
    ${$prefixOutputReference} .= reverse join '', @{$operatorsStack};
    ${$prefixOutputReference} =~ s/\(|\)//g; # remove any brackets from the final output
    return 1;
}

sub getOperatorEntryPriority {
    my ($self, $operator) = @_;
    return $OPERATOR_PRIORITIES->{$operator}->{beforePushPriority};
}

sub getOperatorStackPriority {
    my ($self, $operator) = @_;
    return $OPERATOR_PRIORITIES->{$operator}->{stackPriority};
}

1;