# 6
use strict;
use warnings;
use Text::CSV;
use feature qw(say);

my $delimiter = 'v';
my $count = 0;
my $str = '6813144006v4805780710v4046046198v2562644860v 9046720674v2095347367v7085673674v 8437125275v4049851858v 5012513057v7028086054v9105831241v5203664547v5418177123v 9512396467v8282447125v8643860335v2693574765v2678087010v7573495326v6193729818v5024349790v6783629953v9095164216v8634497842v7572437384v 2106933068v4806886214v 7062889950v 6022067560v 7195538561v 7753858963v9512518482v4422292208v8019136130v6195767557v9164670912v';

$str =~ s/\s+//g;

my @array = split $delimiter, $str;

my $output_file = 'output.csv';
open my $fh_out, '>', $output_file or die "Could not open '$output_file': $!\n";
my $csv = Text::CSV->new({ binary => 1, auto_diag => 1 });
for (@array) {
    $csv->say($fh_out, [$_]);
    $count++;
}

close($fh_out);
say "There are $count total numbers.";