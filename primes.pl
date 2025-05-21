use strict;
use warnings;
use feature qw/ say /;
use Time::HiRes qw(gettimeofday tv_interval);

my $start_time = [gettimeofday];

sub sieve_of_eratosthenes {
    my ($n) = @_;
    return () if $n < 2;

    my @is_prime = (1) x ($n + 1);
    $is_prime[0] = $is_prime[1] = 0;

    for my $i (2 .. sqrt($n)) {
        if ($is_prime[$i]) {
            for (my $j = $i * $i; $j <= $n; $j += $i) {
                $is_prime[$j] = 0;
            }
        }
    }
    my @primes = grep { $is_prime[$_]} (2 .. $n);
    return @primes;
}

my $N = 1000000;
my @primes = sieve_of_eratosthenes($N);
my $random_index = int(rand(@primes));

say $primes[$random_index];

my $end_time = [gettimeofday];
my $elapsed_time = tv_interval($start_time, $end_time);
say "Total time to complete script: $elapsed_time seconds.";