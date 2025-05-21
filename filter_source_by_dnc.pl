use v5.35;
use Text::CSV;

my $dnc_file = 'dnc.csv';
my $input_file = 'input.csv';
my $output_file = 'filtered_dnc_output.csv';

my %dnc_numbers;
{
    my $csv = Text::CSV->new({ binary => 1, auto_diag => 1 });
    open my $fh, '<', $dnc_file or die "Could not open '$dnc_file': $!";

    while (my $row = $csv->getline($fh)) {
        $dnc_numbers{$row->[0]} = 1;
    }
    close $fh;
}

{
    my $csv = Text::CSV->new({ binary => 1, auto_diag => 1 });
    my $out_csv = Text::CSV->new({ binary => 1, auto_diag => 1 });

    open my $in_fh, '<', $input_file or die "Could not open '$input_file': $!";
    open my $out_fh, '>', $output_file or die "Could not open '$output_file': $!";

    my $header = $csv->getline($in_fh);
    $out_csv->print($out_fh, $header);

    while (my $row = $csv->getline($in_fh)) {
        my $phone = $row->[8];

        if (exists $dnc_numbers{$phone}) {
            $out_csv->print($out_fh, $row);
        }
    }
    close $in_fh;
    close $out_fh;
}

say "processing complete. DNC matches written to '$output_file'";
