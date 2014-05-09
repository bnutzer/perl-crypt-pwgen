#!perl -Tw

use Test::More;

use Crypt::PwGen qw(pwgen :consts);

my $len = 15;

my @testflags = (
	PW_DIGITS | PW_UPPERS,
	PW_DIGITS | PW_UPPERS | PW_SYMBOLS | PW_AMBIGUOUS | PW_NO_VOWELS,
	PW_DIGITS | PW_SYMBOLS | PW_AMBIGUOUS,
	PW_UPPERS | PW_SYMBOLS,
	PW_SYMBOLS | PW_AMBIGUOUS | PW_NO_VOWELS,
	PW_DIGITS | PW_NO_VOWELS,
	PW_SYMBOLS,
);

plan tests => 2 * scalar(@testflags);

for my $flag (@testflags) {
	my $pw = pwgen($len, $flag);

	ok($pw, 'Received a password for flag ' . Crypt::PwGen::flagsToStr($flag));
	ok(length($pw) == $len, 'Password is five characters: ' . $pw);
}
