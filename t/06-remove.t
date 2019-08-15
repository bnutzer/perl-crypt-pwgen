#!perl -Tw

use Test::More;

use Crypt::PwGen qw(pwgen :props);

my $len = 150;
my $count = 100;

my $remove = "abc";

plan tests => 1 * $count;

pwgen_rand();

for (my $i = 0; $i < $count; $i++) {

	my $pw = pwgen($len, 0, $remove);

	ok($pw !~ m/[abc]/, "Password does not contain forbidden chars (abc): " . $pw);
}
