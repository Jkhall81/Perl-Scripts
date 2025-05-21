use strict;
use warnings;
use Spreadsheet::XLSX;

if (@ARGV != 2) {
    die "Usage: perl xlsx_to_csv.pl <input.xlsx> <output.csv>\n";
}

my ($xlsx_file, $csv_file) = @ARGV;

my $excel = Spreadsheet::XLSX->new($xlsx_file) or die "Error opening $xlsx_file: $!\n";

open(my $csv_fh, '>', $csv_file) or die "Error opening $csv_file for writing: $!\n";

foreach my $sheet (@{$excel->{Worksheet}}) {
    print "processing sheet: " . $sheet->{Name} . "\n";

    for my $row ($sheet->{MinRow} .. $sheet->{MaxRow}) {
        
        my @row_data;

        for my $col ($sheet->{MinCol} .. $sheet->{MaxCol}) {
            my $cell = $sheet->{Cells}[$row][$col];
            my $value = $cell ? $cell->{Val} : "";

            push @row_data, $value;
        }
        print $csv_fh join(',', @row_data) . "\n";
    }
}

close($csv_fh);
print "Conversion completed: $csv_file\n";