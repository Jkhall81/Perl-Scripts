use strict;
use warnings;
use Text::CSV;

# Input and output file names
my $input_file = 'AllNumbers.csv';
my $output_file = 'duplicates.csv';

my %count;

open my $fh, '<', $input_file or die "Could not open '$input_file' $!\n";

my $csv = Text::CSV->new({ binary => 1, auto_diag => 1 });

while (my $row = $csv->getline($fh)) {
    foreach my $num (@$row) {
        $count{$num}++;
    }
}

close $fh;

open my $out_fh, '>', $output_file or die "Could not open '$output_file' $!\n";

my $has_duplicates = 0;  # Flag
foreach my $num (keys %count) {
    if ($count{$num} > 1) {
        $csv->print($out_fh, [$num]);
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