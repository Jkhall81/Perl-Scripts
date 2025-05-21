use v5.40;

open my $in, '<', 'mysqld.log' or die "Cannot open log file: $!\n";

my @tables;
my %unique_tables;

while (my $line = <$in>) {
    if ($line =~ /\[ERROR\] .*?Incorrect key file for table '([^']+)'/) {
        my $table = $1;
        push @tables, $table;         
        $unique_tables{$table} = 1;   
    }
}
close $in;

my @unique_tables = keys %unique_tables;

# Print results
# say "All tables (with duplicates):";
# say join("\n", @tables);

say "\nUnique tables (Set-like):";
say join("\n", @unique_tables);