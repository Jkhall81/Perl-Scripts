use strict;
use warnings;
use Text::CSV;
use feature qw(say);

my @list1_files = ('Monti_VA_NewList10-09-24a-1.csv', 'Monti_VA_NewList10-09-24a-2.csv');
my @list2_files = ('21234.csv', '21235.csv');
my $output_file = 'output.csv';
my %list1_numbers;
my %list2_numbers;
my $csv = Text::CSV->new({ binary => 1, auto_diag => 1 });

sub read_files_into_hash {
    my ($files, $hash_ref) = @_;
    foreach my $file (@$files) {
        open my $fh, '<', $file or die "Could not open '$file' $!\n";
        while (my $row = $csv->getline($fh)) {
            foreach my $num (@$row) {
                $hash_ref->{$num} = 1;
            }
        }
        close $fh;
    }
}

read_files_into_hash(\@list1_files, \%list1_numbers);
read_files_into_hash(\@list2_files, \%list2_numbers);

open my $out_fh, '>', $output_file or die "Could not open '$output_file' $!\n";
my $common_count = 0;

foreach my $num (keys %list2_numbers) {
    if (exists $list1_numbers{$num}) {
        say $out_fh $num;  # Output each number on a new line
        $common_count++;
    }
}

close $out_fh;
say "There are $common_count numbers from list 2 in list 1.";
say "Common numbers have been written to '$output_file'.";