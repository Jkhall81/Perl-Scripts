use strict;
use warnings;
use Text::CSV;
use feature qw(say);

# Input and output file names
my $file1 = 'file1.csv';
my $file2 = 'file2.csv';
my $output_file = 'output.csv';

my %file2_numbers;

# Read file 2 into a hash for quick lookup
open my $file2_fh, '<', $file2 or die "Could not open '$file2' $!\n";
my $csv = Text::CSV->new({ binary => 1, auto_diag => 1 });

while (my $row = $csv->getline($file2_fh)) {
    foreach my $num (@$row) {
        $file2_numbers{$num} = 1;
    }
}

close $file2_fh;

# Open file 1 and output matching numbers
open my $file1_fh, '<', $file1 or die "Could not open '$file1' $!\n";
open my $out_fh, '>', $output_file or die "Could not open '$output_file' $!\n";
my $count = 0;

while (my $row = $csv->getline($file1_fh)) {
    my @common = grep { exists $file2_numbers{$_} } @$row;
    if (@common) {
        $csv->print($out_fh, \@common);
        $count++;
    }
}

close $file1_fh;
close $out_fh;

say "$count duplicate numbers have been written to '$output_file'.";