package Noxu::Copy;

use parent 'Noxu::Base';

use IO::All -utf8;
use File::Basename;

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

    print "  [copy] copying " . basename( $task->{ 'from' } );

    io( $task->{ 'to' } ) < io( $task->{ 'from' } );

    print "  (OK)\n";

    return $self;
}

1;
