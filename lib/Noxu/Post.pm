package Noxu::Post;

use base 'Noxu::Base';

use HTTP::Request::Common;
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
    my ( $self, $task, $form, %args ) = ( @_, "application/x-www-form-urlencoded" );

    print "  [post] posting against " . $task->{ 'url' };

    # ------------------------------------
    # @varialbes

    foreach my $parm ( @{ $task->{ 'parameters' } } )
    {
        $args{ $parm->{ 'name' } } = $parm->{ 'value' };
    }

    if ( $task->{ 'type' } )
    {
        $form = $task->{ 'type' };
    }

    if ( $task->{ 'resource' } )
    {
        $form = "form-data";
        $args{ $task->{ 'resource' }->{ 'name' } }
            = [ io( $task->{ 'resource' }->{ 'file' } )->absolute->pathname ];
    }

    # ------------------------------------
    # @request

    my $request = HTTP::Request::Common::POST(
        $task->{ 'url' },
        Content_Type => $form,
        Content      => [ %args ]
    );

    if ( $task->{ 'authentication' } )
    {
        $request->authorization_basic( $task->{ 'authentication' }->{ 'username' },
            $task->{ 'authentication' }->{ 'password' } );
    }

    my $httpclient = $self->httpclient();

    my $response = $httpclient->request( $request );

    if ( $response->is_success )
    {
        $self->logger( "httpclient/post", $response->decoded_content );
    }
    else
    {
        $self->logger( "httpclient/post", $response->status_line );
    }

    print " (OK)\n";

    return $self;
}

1;
