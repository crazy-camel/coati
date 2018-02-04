package Noxu::Clean;

use parent 'Noxu::Base';
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

    print "  [clean] deleting the following resources:\n";

    foreach my $res ( @{ $task->{ 'resources' } } )
    {
        print "   - $res\n";

        $self->clear( $res );
    }

    return $self;
}

# ================================================== -->
# clear
# @description: removes a resource (directory/file)
# @params:
#  - @scalar: path 
# @returns:
#  - reference directory/file
# ================================================== -->
sub clear
{

    my ( $self, $path ) = @_;

    my $io = io( $path );

    if ( $io->exists() )
    {
        if ( $io->is_dir() )
        {
            return $io->rmtree();
        }

        if ( $io->is_file() )
        {
            return $io->unlink();
            
        }
    }

    #if ( $io->name =~ /\.[a-z0-9]$/i )
    #{
    #    return $io->touch();
    #}

    #return $io->mkdir();

}

1;
