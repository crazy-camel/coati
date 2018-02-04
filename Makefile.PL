use 5.026001;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME              => 'Noxu',
    VERSION_FROM      => 'lib/Noxu.pm', # finds $VERSION, requires EU::MM from perl >= 5.5
    PREREQ_PM         => {
    	'Object::Tiny' => 1.08,
    	'YAML::Tiny' => 1.70,
    	'IO::All' => 0.87,
    	'DateTime::Tiny' => 1.06,
    	'LWP::UserAgent' => 6.31,
    	'HTTP::Cookies' => 6.04,
    	'LWP::Protocol::https' => 6.07,
    	'File::Basename' => 2.85,
    	'HTTP::Request::Common' => 6.14,
    	'IPC::Run3' => 0.048,
    	'Module::Load'=> 0.32
    }, # e.g., Module::Name => 1.1
    ABSTRACT_FROM     => 'lib/Noxu.pm', # retrieve abstract from module
    AUTHOR            => 'Xerocole <development@crazycamel.ca>',
    #LICENSE           => 'perl',
    #Value must be from legacy list of licenses here
    #http://search.cpan.org/perldoc?Module%3A%3ABuild%3A%3AAPI
);
