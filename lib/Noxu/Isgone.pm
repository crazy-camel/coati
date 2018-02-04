package Noxu::Isgone;

use base 'Noxu::Base';

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

	my ( $self, $task, $status ) = ( @_, 200 );

    # ------------------------------------
    # @httpclient
    my $httpclient = $self->httpclient( 3 );

    print "  [isgone] waiting for $task->{'url'} to be not be available";

    while ( $status == 200 )
    {

        my $response = $httpclient->get( $task->{url} );

        $status = $response->code();

        sleep 1;
    }

    print "  (OK)\n";
}


1;