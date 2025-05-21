use v5.35;

my $str = "";

for (my $i = 0; $i < 100; $i++) {
    my $randNum = int(1000000000 + rand(9999999999));
    $str .= $randNum;
}

my @numbers = $str =~ /(\d{10})/g;
my $length = @numbers;
say $length;

# my $finishedStr = join ",", map {"'$_'"} @numbers;

# say $finishedStr;

my @filteredArray = grep { /^4/ } @numbers;
say for @filteredArray;