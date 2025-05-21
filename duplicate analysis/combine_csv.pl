use strict;
use warnings;
use Text::CSV;
use feature qw(say);

if (@ARGV != 3) {
    die "Usage: perl combine_csv.pl <input_file1> <input_file2> <output_file>\n";
}

my ($input_file1, $input_file2, $output_file) = @ARGV;

sub read_phone_numbers {
    my ($file) = @_;
    my $csv = Text::CSV->new({ binary => 1, auto_diag => 1 });
    open(my $fh, '<', $file) or die "Could not open file '$file': $!";
    my @numbers;
    while (my $row = $csv->getline($fh)) {
        for my $field (@$row) {
            push @numbers, $field if $field =~ /^\d+$/; # Ensure it's a valid number
        }
    }
    close($fh);
    return @numbers;
}

my @numbers1 = read_phone_numbers($input_file1);
my @numbers2 = read_phone_numbers($input_file2);
my @combined_numbers = (@numbers1, @numbers2);

my $csv = Text::CSV->new({ binary => 1, auto_diag => 1 });
open(my $fh_out, '>', $output_file) or die "Could not open file '$output_file': $!";
$csv->say($fh_out, [$_]) for @combined_numbers;
close($fh_out);

say "Combined phone numbers have been written to '$output_file'.";