use 5.006001;
use ExtUtils::MakeMaker;
use ExtUtils::Liblist;

use lib 'inc/';
use Devel::CheckLib;
check_lib_or_exit(
	LIBS	=> '-lpwgen',
	incpath => ['.'],
	header	=> ['pwgen.h', 'pw_number.h'],
);


WriteMakefile(
    NAME                => 'Crypt::PwGen',
    AUTHOR              => 'Bastian Friedrich <bastian@friedrich.link>',
    VERSION_FROM        => 'lib/Crypt/PwGen.pm',
    ABSTRACT_FROM       => 'lib/Crypt/PwGen.pm',
    PREREQ_PM           => {
        'Exporter'      => 0,
        'Test::More'    => 0,
        'Test::Builder' => 0,
    },

    NEEDS_LINKING       => 1,
    INC                 => '-I.',
    LIBS		=> ['-lpwgen'],

    EXE_FILES           => [],
    dist => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean => { FILES => 'Crypt-PwGen-*.tar.*' },
);
