package Noxu::Plugin::Combine;

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

    print "  [combine] $task->{name}...";

    my $filename = $self->stage( $task->{ 'name' } );

    foreach my $prt ( @{ $task->{ 'sequence' } } )
    {
        my $binary = io( $prt )->binary->all;

        $filename->binary->append( $binary );
    }

    print "  (OK)\n";

    return $self;
}

# ================================================== -->
# stage
# @description: ensures the resource is clear
# @params:
#  - @scalar: path - path to resource
# @returns:
#  - the absolute path to resource
# ================================================== -->
sub stage
{
    my ( $self, $path ) = @_;

    my $io = io( $path );

    if ( $io->is_dir() )
    {
        print "  [clear] ERROR : cannot truncate a directory $path\n";
        exit( 0 );
    }

    $io->unlink() if $io->exists();

    $io->touch();

    return $io->absolute()->pathname;
}

1;
