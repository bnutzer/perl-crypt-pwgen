/*
 * Copyright (C) 2014 Bastian Friedrich <bastian@friedrich.link>
 */
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include "pwgen.h"
#include <unistd.h>

#define MY_CXT_KEY "Crypt::PwGen::_guts" XS_VERSION

int (*pw_number)(int max_num);

typedef struct {
	int gen;
} my_cxt_t;

START_MY_CXT

MODULE = Crypt::PwGen PACKAGE = Crypt::PwGen

PROTOTYPES: ENABLE

BOOT:
	/*
	 * Set generator to "phonemes", number generator to "random number"
	 */
	{
		MY_CXT_INIT;
		MY_CXT.gen = 1;
	}
	pw_number = pw_random_number;

void
pwgen_phonemes()
    PREINIT:
	dMY_CXT;
    CODE:
	MY_CXT.gen = 1;

void
pwgen_rand()
    PREINIT:
	dMY_CXT;
    CODE:
	MY_CXT.gen = 2;

void
pwgen_random_number()
    CODE:
	pw_number = pw_random_number;

void
pwgen_sha1_number(sha1)
	char *sha1
    CODE:
	pw_sha1_init(sha1);
	pw_number = pw_sha1_number;

SV *
pwgen(len, flags = PW_DIGITS | PW_UPPERS, remove = "")
        int len
        int flags
	char *remove
    PREINIT:
	dMY_CXT;
	char *buf;
	void (*pwgen)(char *inbuf, int size, int pw_flags, char *remove);
    CODE:
	if (len < 1) {
		Perl_croak(aTHX_ "len must be positive");
	} else if (len > 1023) {
		Perl_croak(aTHX_ "maximum len of 1023 exceeded");
	}

	printf("Remove is %s\n", remove);

	if (MY_CXT.gen == 1) {
		pwgen = pw_phonemes;
	} else {
		pwgen = pw_rand;
	}

	buf = (char *)malloc(len + 1);

	pwgen(buf, len, flags, remove);

	RETVAL = newSVpv(buf, 0);

	free(buf);
    OUTPUT:
	RETVAL
