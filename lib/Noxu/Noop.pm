package Noxu::Noop;

use parent 'Noxu::Base';

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

    print "  [noop] skipping $task->{ 'action' } unknown action" ;

    print "  (OK)\n";

    return $self;
}

1;
