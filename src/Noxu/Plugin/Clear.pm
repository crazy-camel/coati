package Noxu::Plugin::Clear;

use parent 'Noxu::Plugin::Base';
use IO::All -utf8;

# ================================================== -->
# execute
# @description: the plugin handler
# @params:
#  - @scalar: task 
# @returns:
#  - reference to self for chaining
# ================================================== -->
sub execute
{
    my ( $self, $task ) = @_;

    print "  [clear] clearing the following resources:\n";

    foreach my $res ( @{ $task->{ 'resources' } } )
    {
        print "   - $res\n";

        $self->truncate( $res );
    }

    return $self;
}

# ================================================== -->
# truncate
# @description: clear the contents of a file
# @params:
#  - @scalar: path  to resource 
# @returns:
#  - reference to file
# ================================================== -->
sub truncate
{

    my ( $self, $path ) = @_;

    my $io = io( $path );

    if ( $io->is_dir() )
    {
        print "  [clear] ERROR : cannot truncate a directory $path\n";
        exit( 0 );
    }

    $io->unlink() if $io->exists();

    return $io->touch();

}

1;
