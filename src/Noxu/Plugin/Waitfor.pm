package Noxu::Plugin::Waitfor;

use parent 'Noxu::Plugin::Base';

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

    my ( $self, $task, $status ) = @_;

    # ------------------------------------

    my $httpclient = $self->httpclient( 3 );

    print "  [waitfor] waiting for $task->{'url'} to be available";

    while ( $status != 200 )
    {

        my $response = $httpclient->get( $task->{ 'url' } );

        $status = $response->code();

        sleep 1;
    }

    print "  (OK)\n";

    return $self;
}

1;
