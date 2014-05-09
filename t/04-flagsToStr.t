#!perl -Tw

use Test::More tests => 1;

use Crypt::PwGen qw(pwgen :consts);

ok(Crypt::PwGen::flagsToStr(PW_DIGITS | PW_SYMBOLS) eq 'PW_DIGITS | PW_SYMBOLS',
	'flagsToStr for PW_DIGITS | PW_SYMBOLS returned that string');
