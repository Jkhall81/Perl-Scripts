use strict;
use warnings;
use Text::CSV;

# Input and output file names
my $input_file = 'AllNumbers.csv'; 
my $output_file = 'uniques.csv';


my %count;

# Open the input CSV file
open my $fh, '<', $input_file or die "Could not open '$input_file' $!\n";

# Create a CSV parser
my $csv = Text::CSV->new({ binary => 1, auto_diag => 1 });

while (my $row = $csv->getline($fh)) {
    foreach my $num (@$row) {
        $count{$num}++;
    }
}

close $fh;

# Open the output CSV file for writing
open my $out_fh, '>', $output_file or die "Could not open '$output_file' $!\n";

my $has_uniques = 0;  # Flag 
foreach my $num (keys %count) {
    if ($count{$num} == 1) {
        $csv->print($out_fh, [$num]);
        print $out_fh "\n";  
        $has_uniques = 1;  # Set flag
    }
}

close $out_fh;

if ($has_uniques) {
    print "Uniques have been written to '$output_file'.\n";
} else {
    print "No uniques found.\n";
}