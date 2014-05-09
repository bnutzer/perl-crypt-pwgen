#!perl -Tw

use Test::More tests => 2;

use Crypt::PwGen;

my $len = 15;

my $pw = pwgen($len);

ok($pw, 'Received a password');
ok(length($pw) == $len, 'Password is five characters: ' . $pw);
