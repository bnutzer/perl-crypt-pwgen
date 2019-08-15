# Copyright (c) 2014 Bastian Friedrich
package Crypt::PwGen;

use 5.006001;
use strict;

require Exporter;
require DynaLoader;

our @ISA = qw(Exporter DynaLoader);
our @EXPORT = qw(pwgen);
our %EXPORT_TAGS = (
	consts	=> [qw(
		PW_DIGITS
		PW_UPPERS
		PW_SYMBOLS
		PW_AMBIGUOUS
		PW_NO_VOWELS
	)],
	props	=> [qw(
		pwgen_phonemes
		pwgen_rand
		pwgen_random_number
		pwgen_sha1_number
	)],
);
our @EXPORT_OK = (@{$EXPORT_TAGS{consts}}, @{$EXPORT_TAGS{props}});

#
# Constants taken from pwgen.h
#
use constant CONSONANT		=> 0x0001;
use constant VOWEL		=> 0x0002;
use constant DIPTHONG		=> 0x0004;
use constant NOT_FIRST		=> 0x0008;

use constant PW_DIGITS		=> 0x0001;	# /* At least one digit */
use constant PW_UPPERS		=> 0x0002;	# /* At least one upper letter */
use constant PW_SYMBOLS		=> 0x0004;
use constant PW_AMBIGUOUS	=> 0x0008;
use constant PW_NO_VOWELS	=> 0x0010;

=head1 NAME

Crypt::PwGen - An interface to tytso's pwgen

=head1 VERSION

Version 1.0

=cut

our $VERSION = '1.0';

=head1 SYNOPSIS

    use Crypt::PwGen;

    print("A five character default settings password: " . pwgen(5, 0));

=head1 Description

C<Crypt::PwGen> uses tytso's pwgen code for providing random pronouncable
passwords.

Please see the included README file for more information. Using Crypt::PwGen
in a threading environment is not advisable.

=head1 Exports

Function C<pwgen($length [, $flags [, $remove]])>

Exportable Tags:

Tag C<:consts> includes the flag constants:

=over

=item

PW_DIGITS

=item

PW_UPPERS

=item

PW_SYMBOLS

=item

PW_AMBIGUOUS

=item

PW_NO_VOWELS

=back


Tag C<:props> includes the property functions

=over

=item

C<pw_phonemes>

=item

C<pw_rand>

=item

C<pw_random_number>

=item

C<pw_sha1_number(sha1)>

=back

=cut

=head1 Function description

=head2 Function C<pwgen($len [, $flags [, $remove]])>

The main, most important and quite possibly only used function in this module.
Returns a newly generated password.

The C<$len> argument must be a positive number between 1 and 1023. When the
optional C<$flags> argument is omitted, it defaults to PW_DIGITS | PW_UPPERS.

In the "random characters" mode (after calling C<pwgen_rand()>), a string
containing characters to be removed from the output may be passed in the
C<$remove> argument. Please note that this argument is ignored in the default
"phonemes" mode.

=head2 Function C<pwgen_phonemes()>

Sets the password generator the the "phonemes" method, resulting in
pronouncable passwords (or what tytso regarded as pronouncable)

=head2 Function C<pwgen_rand()>

Sets the password generator to "random characters" mode

=head2 Function C<pwgen_random_number()>

Makes pwgen use a random number as the password base. Results in random
passwords.

=head2 Function C<pwgen_sha1_number($sha1)>

Makes pwgen use a non-random number as the password base. Results in
reproducable passwords.

The C<sha1> argument is expected to point to a file, optionally extended with
a string "#seed"; pwgen will then calculate that file's sha1 hash and use
it for calculating new passwords.

When the same sha1 file is re-used, the generated password will be the same.
Please note that this may easily result in insecure passwords!

=head2 Function flagsToStr($flags)

Returns a string representation of the $flags variable:

 my $flags = PW_DIGITS | PW_UPPERS;
 print("Flags are " . flagsToStr($flags));

=cut

sub flagsToStr($) {
	my $f = shift;

	my @s = ();

	if ($f & PW_DIGITS)	{ push @s, 'PW_DIGITS'; }
	if ($f & PW_UPPERS)	{ push @s, 'PW_UPPERS'; }
	if ($f & PW_SYMBOLS)	{ push @s, 'PW_SYMBOLS'; }
	if ($f & PW_AMBIGUOUS)	{ push @s, 'PW_AMBIGUOUS'; }
	if ($f & PW_NO_VOWELS)	{ push @s, 'PW_NO_VOWELS'; }

	return join(' | ', @s);
}

bootstrap Crypt::PwGen;

=head1 SEE ALSO

Various other password generator modules are available. A comparison
is available from
L<http://neilb.org/reviews/passwords.html>

L<Data::Pwgen> is another perl module called pwgen.

=cut

1;
