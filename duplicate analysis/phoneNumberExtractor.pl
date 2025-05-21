use strict;
use warnings;
use Text::CSV;
use POSIX;
use Getopt::Long;

# Parse command-line
my $has_header = 1;
GetOptions('header' => \$has_header);


# Get input file
print "Please enter the input file name WITH the file extension.  File must be in the SAME directory as this script.\n";
chomp(my $input_file = <STDIN>);

# getting date for output file name
my $date = strftime('%m_%d_%Y', localtime);

# IO file names
my $output_file = "extractedNumbers_$date.csv";

# Input file
open my $fh, '<', $input_file or die "Could not open '$input_file': $!\n";
my $csv = Text::CSV->new({ binary => 1, auto_diag => 1 });

# Output file
open my $out_fh, '>', $output_file or die "Could not open '$output_file': $!\n";
my $out_csv = Text::CSV->new({ binary => 1, auto_diag => 1 });

# Write output file header
$out_csv->say($out_fh, ['phone_numbers']);

my $index = 0;
my $phoneNumber_index;
my $phone_index_found = 0;

if ($has_header) {
    $csv->getline($fh);
}

while (my $row = $csv->getline($fh)) {
    foreach my $num (@$row) {
        if ($num =~ /^1\d{10}$/ || ($num =~ /^\d{10}$/ && $num !~ /^1/)) {
            $phoneNumber_index = $index;
            $phone_index_found = 1;
            last;
        } 
        $index++;
    }
    last if $phone_index_found;
}


if ($phone_index_found) {
    print "Found an index with a valid phone number.  Beginning number extraction.\n";

    seek($fh, 0, 0);

    if ($has_header) {
        $csv->getline($fh);
    }

    while (my $row = $csv->getline($fh)) {
        if (defined $row->[$phoneNumber_index]) {
            $out_csv->say($out_fh, [$row->[$phoneNumber_index]]);
        }
    }

    print "Phone numbers have been extracted to '$output_file'.\n";
} else {
    print "No valid phone numbers found.\n";
}

close $fh;
close $out_fh;
