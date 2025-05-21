use strict;
use warnings;
use File::Path qw(make_path);
use POSIX qw(strftime);

if (@ARGV != 1) {
    die "Usage: $0 <input_file.txt>\n";
}

my $input_file = $ARGV[0];
my $numbers_per_file = 50_000;
my $output_dir = "output_" . strftime("%m_%d_%Y", localtime);

unless (-d $output_dir) {
    make_path($output_dir) or die "Failed to create directory '$output_dir': $!\n";
}

open(my $in, '<', $input_file) or die "Could not open file '$input_file': $!\n";
my @numbers;
my $file_count = 0;
my $line_count = 0;

while (my $line = <$in>) {
    chomp($line);
    push @numbers, $line;
    $line_count++;

    # Write to a new file after every 50,000 numbers
    if ($line_count == $numbers_per_file) {
        $file_count++;
        write_to_file($output_dir, $file_count, \@numbers);
        @numbers = (); # Clear the array
        $line_count = 0;
    }
}

# Write any remaining numbers
if (@numbers) {
    $file_count++;
    write_to_file($output_dir, $file_count, \@numbers);
}

close $in;
print "Files created in directory '$output_dir'\n";

sub write_to_file {
    my ($dir, $count, $numbers_ref) = @_;
    my $date = strftime("%m_%d_%Y", localtime);
    my $file_name = sprintf("%s/output_%s_%d.txt", $dir, $date, $count);
    open(my $out, '>', $file_name) or die "Could not create file '$file_name': $!\n";
    print $out join("\n", @$numbers_ref) . "\n";
    close $out;
    print "Created file: $file_name\n";
}