package PolishNotation::OperatorPriorities;

use Exporter qw(import);

our @EXPORT = qw($OPERATOR_PRIORITIES);

our $OPERATOR_PRIORITIES = {
    '(' => {
        beforePushPriority => 2,
    },
    ')' => {
        beforePushPriority => 100,
        stackPriority => 2,
    },
    '+' => {
        beforePushPriority => 3,
        stackPriority => 3,
    },
    '-' => {
        beforePushPriority => 3,
        stackPriority => 3,
    },
    '/' => {
        beforePushPriority => 4,
        stackPriority => 4,
    },
    '*' => {
        beforePushPriority => 4,
        stackPriority => 4,
    },
    '%' => {
        beforePushPriority => 4,
        stackPriority => 4,
    },
    '^' => {
        beforePushPriority => 6,
        stackPriority => 5,
    },
};

1;