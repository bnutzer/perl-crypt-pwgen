#!perl -Tw

use Test::More;

use Crypt::PwGen;

my $len = 15;
my $count = 10;

plan tests => 2 * $count;

for (my $i = 0; $i < $count; $i++) {

	my $pw = pwgen($len, 0);

	ok($pw, 'Received a password');
	ok(length($pw) == $len, 'Password is five characters: ' . $pw);
}
