package Noxu::Plugin::Delete;

use parent 'Noxu::Plugin::Base';

use HTTP::Request::Common;

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

    print "  [delete] posting against $task->{url}";

    # ------------------------------------

    my $request = HTTP::Request::Common::DELETE( $task->{ 'url' } );

    if ( $task->{ 'authentication' } )
    {
        $request->authorization_basic( 
            $task->{ 'authentication' }->{ 'username' },
            $task->{ 'authentication' }->{ 'password' }
        );
    }

    # ------------------------------------

    my $httpclient = $self->httpclient( 3 );

    my $response = $httpclient->request( $request );

    if ( $response->is_success )
    {
        $self->logger( "httpclient/delete", $response->decoded_content );
    }
    else
    {
        $self->logger( "httpclient/delete", $response->status_line );
    }

    print "  (OK)\n";

    return $self;
}

1;
