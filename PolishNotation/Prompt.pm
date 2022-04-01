package PolishNotation::Prompt;

sub promptForString {
    my ($class, $prompt) = @_;
    print $prompt;
    my $input = <STDIN>;
    chomp $input;
    return $input;
}

sub promptForBoolean {
    my ($class, $prompt) = @_;
    while(1) {
        print "$prompt (y/n) [n]: ";
        my $input = <STDIN>;
        chomp $input;
        $input =~ s/\s*//g;
        $input = 'n' if !length($input);
        if($input !~ /^(y|n)$/i) {
            say STDOUT "Invalid input!";
            next;
        }
        return 0 if lc($input) eq 'n';
        return 1;
    }
}

1;