use strict;
use warnings;

if (@ARGV != 4) {
    die "Usage: perl $0 <total_list.txt> <clean_list.txt> <fdnc_list.txt> <output.txt>\n";
}

my ($total_file, $clean_file, $fdnc_file, $output_file) = @ARGV;
my %total_numbers = read_file_to_hash($total_file);
my %clean_numbers = read_file_to_hash($clean_file);
delete @total_numbers{keys %clean_numbers};
my %fdnc_numbers = read_file_to_hash($fdnc_file);
delete @total_numbers{keys %fdnc_numbers};

write_hash_to_file(\%total_numbers, $output_file);

print "Filtered list written to $output_file\n";

sub read_file_to_hash {
    my ($file_path) = @_;
    open my $fh, '<', $file_path or die "Cannot open file '$file_path': $!\n";
    my %hash;
    while (my $line = <$fh>) {
        chomp $line;
        $hash{$line} = 1; 
    }
    close $fh;
    return %hash;
}

sub write_hash_to_file {
    my ($hash_ref, $file_path) = @_;
    open my $fh, '>', $file_path or die "Cannot write to file '$file_path': $!\n";
    print $fh "$_\n" for sort keys %$hash_ref;
    close $fh;
}