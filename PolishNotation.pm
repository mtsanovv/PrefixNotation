package PolishNotation;

use PolishNotation::Utils;
use PolishNotation::Prompt;
use PolishNotation::PrefixConverter;

our $HEADER = 'Polish Notation Converter (Infix to Prefix)';

sub new {
    my ($class) = @_;
    bless {}, $class;
}

sub initPolishNotationConverter {
    my ($self) = @_;
    $self->printHeader();
    $self->requestInput();
    return 1;
}

sub requestInput {
    my ($self) = @_;
    while(1) {
        my $infixInput = PolishNotation::Prompt->promptForString("Enter an infix expression to convert (make sure that it is correct): ");
        $self->parseInput($infixInput);
        my $shouldContinue = PolishNotation::Prompt->promptForBoolean("Would you like to convert another expression? ");
        last if !$shouldContinue;
    }
    return 1;
}

sub parseInput {
    my ($self, $input) = @_;
    PolishNotation::Utils->removeWhitespaces(\$input);
    if(!PolishNotation::Utils->isValidInput($input)) {
        say STDOUT "Invalid input!";
        return 0;
    }
    my $reversedInput = reverse $input;
    my $prefixConverter = PolishNotation::PrefixConverter->new($reversedInput);
    my $prefixExpression = $prefixConverter->convertToPrefix();
    say STDOUT "Converted to prefix expression: $prefixExpression";
    return 1;
}

sub printHeader {
    my $headerMessageLength = length($HEADER);
    say STDOUT "\n\n" . '*' x $headerMessageLength;
    say STDOUT $HEADER;
    print '*' x $headerMessageLength . "\n\n";
}

1;