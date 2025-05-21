use strict;
use warnings;
use Text::CSV;

# Input and output file names
my $input_file1 = 'Monti_VA_NewList10-09-24a-1.csv';
my $input_file2 = 'Monti_VA_NewList10-09-24a-2.csv';
my $output_file = 'test_output_frequency.csv';

my %count;

# Subroutine to process a file and count occurrences of numbers
sub process_file {
    my ($file, $count_ref) = @_;

    open my $fh, '<', $file or die "Could not open '$file' $!\n";

    my $csv = Text::CSV->new({ binary => 1, auto_diag => 1 });

    while (my $row = $csv->getline($fh)) {
        foreach my $num (@$row) {
            $count_ref->{$num}++;
        }
    }

    close $fh;
}

# Process both input files
process_file($input_file1, \%count);
process_file($input_file2, \%count);

# Find duplicates and write to output file
open my $out_fh, '>', $output_file or die "Could not open '$output_file' $!\n";

my $csv = Text::CSV->new({ binary => 1, auto_diag => 1 });
my $has_duplicates = 0;  # Flag

foreach my $num (keys %count) {
    if ($count{$num} > 1) {
        # Print the number along with its frequency
        $csv->print($out_fh, [$num, $count{$num}]);
        print $out_fh "\n";
        $has_duplicates = 1;  # Set flag
    }
}

close $out_fh;

if ($has_duplicates) {
    print "Duplicates have been written to '$output_file'.\n";
} else {
    print "No duplicates found.\n";
}