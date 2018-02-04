package Noxu::Plugin::Clean;

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
            $io->rmtree();
            return $io->mkdir();
        }

        if ( $io->is_file() )
        {
            $io->unlink();
            return $io->touch();
        }
    }

    if ( $io->name =~ /\./ )
    {
        return $io->touch();
    }

    return $io->mkdir();

}

1;
