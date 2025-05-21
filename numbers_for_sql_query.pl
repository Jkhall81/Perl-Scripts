use v5.35;

my $str = '';

my @newStr = $str =~ /(\d{10})/g;

my @array1 = @newStr[0..999];
my @array2 = @newStr[1000..1999];
my @array3 = @newStr[2000..2999];
my @array4 = @newStr[3000..3251];

sub format_for_sql {
    my @numbers = @_;
    return join(", ", map { "'$_'" } @numbers);
}

my $sql_chunk1 = format_for_sql(@array1);
my $sql_chunk2 = format_for_sql(@array2);
my $sql_chunk3 = format_for_sql(@array3);
my $sql_chunk4 = format_for_sql(@array4);

say $sql_chunk4;