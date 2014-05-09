#!perl -Tw

use Test::More;

use Crypt::PwGen qw(pwgen :props);

my $len = 15;

plan tests => 2 * 2 * 2;

sub gen($) {
	my $s = shift;

	my $pw = pwgen($len, 0);

	ok($pw, sprintf('Received a password for combination %s', $s));
	ok(length($pw) == $len, sprintf('Password is %d characters: %s', $len, $pw));
}

my $p = $0;	# Use script name as sha1 input

pwgen_phonemes();	pwgen_random_number();	gen("pwgen_phonemes/pwgen_random_number");
pwgen_phonemes();	pwgen_sha1_number($p);	gen("pwgen_phonemes/pwgen_sha1_number");
pwgen_rand();		pwgen_random_number();	gen("pwgen_rand/pwgen_random_number");
pwgen_rand();		pwgen_sha1_number($p);	gen("pwgen_rand/pwgen_sha1_number");
