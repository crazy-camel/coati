use 5.026001;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME              => 'Noxu',
    VERSION_FROM      => 'lib/Noxu.pm', # finds $VERSION, requires EU::MM from perl >= 5.5
    PREREQ_PM         => {
    	'Object::Tiny' => 1,
    	'YAML::Tiny' => 1,
    	'IO::All' => 0,
    	'DateTime::Tiny' => 1,
    	'LWP::UserAgent' => 6,
    	'HTTP::Cookies' => 6,
    	'LWP::Protocol::https' => 6,
    	'File::Basename' => 2,
    	'HTTP::Request::Common' => 6,
    	'IPC::Run3' => 0,
    	'Module::Load'=> 0,
        'Module::Load::Conditional' => 0,
        'Scalar::Util' => 1
    }, # e.g., Module::Name => 1.1
    ABSTRACT_FROM     => 'lib/Noxu.pm', # retrieve abstract from module
    AUTHOR            => 'Xerocole <development@crazycamel.ca>',
    #LICENSE           => 'perl',
    #Value must be from legacy list of licenses here
    #http://search.cpan.org/perldoc?Module%3A%3ABuild%3A%3AAPI
);
