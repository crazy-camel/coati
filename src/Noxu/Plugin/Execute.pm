package Noxu::Plugin::Execute;

use parent 'Noxu::Plugin::Base';

use IO::All -utf8;
use IPC::Run3;
use Config;

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
    my ( $self, $task, $dir ) = @_;

    my $os
        = ( $Config{ 'osname' } eq "darwin" ) ? "mac"
        : ( $Config{ 'osname' } eq "MSWin32" ) ? "win"
        :                                        "other";

    my $resource
        = ( $task->{ 'resource' }->{ $os } )
        ? $task->{ 'resource' }->{ $os }
        : $task->{ 'resource' }->{ 'other' };

    if ( $task->{ 'directory' } )
    {
        $dir = io( $task->{ 'directory' } )->chdir;
    }

    my @cmd = ( io( $resource )->absolute->pathname );

    if ( $task->{ 'parameters' } )
    {
        foreach my $parm ( @{ $task->{ 'parameters' } } )
        {
            push @cmd, $parm;
        }
    }

    print "  [execute] executing $resource ...";

    run3 \@cmd, \undef, \undef, \undef;

    print "  (OK)\n";

    return $self;
}

1;
