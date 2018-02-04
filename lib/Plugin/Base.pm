############################################################
# @package:         Noxu::Plugin::Base
# @description:     Base extended object for all plugins
# @version:         v1.0
# @author:          Crazy Camel
############################################################
package Noxu::Plugin::Base;

use utf8;
use strict;
use warnings;

use Object::Tiny;

use DateTime::Tiny;
use IO::All -utf8;

use LWP::UserAgent;
use LWP::ConnCache;
use HTTP::Cookies;

# ================================================== -->
# handle
# @description: the main handle function for the plugin
# @params:
#  - @object: task - task parameters
# @returns:
#  - reference to self for chaining
# ================================================== -->
sub handle
{
    my ( $self, $task ) = @_;

    return ( defined $task->{ 'pause' } )
        ? $self->execute( $task )->pause( $task->{ 'pause' } )
        : $self->execute( $task );

}

# ================================================== -->
# pause
# @description: the pause function that allows plugins to pause after there execution
# @params:
#  - @scalar: pause - minutes to pause for
# @returns:
#  - reference to self for chaining
# ================================================== -->
sub pause
{

    my ( $self, $pause ) = @_;

    print "     [pause] waiting for $pause minutes ";

    sleep( 60 * $pause );

    print "  (OK)\n";

    return $self;
}

# ================================================== -->
# logger
# @description: a logger function that allows plugins log events/messages to the logfile
# @params:
#  - @scalar: idnt - the plugin identifier
#  - @scalar: message - the text to put in the log file
# @returns:
#  - reference to self for chaining
# ================================================== -->
sub logger
{
    my ( $self, $id ,$message ) = @_;

    my $time = DateTime::Tiny->now();

    my $stamp
        = "["
        . $time->year() . "-"
        . $time->month() . "-"
        . $time->day() . " "
        . $time->hour() . ":"
        . $time->minute() . ":"
        . $time->second() . "]";

    $message =~ s/\R/ /g;    # lets remove new lines to keep things one line in the log;

    io( 'noxu.log' )->append( "[$stamp] [$id] $message" );

    return $self;
}

# ================================================== -->
# httpclient
# @description: creates a cache httpclient object
# @params:
#  - @scalar: timeout - sets the timeout for the httpclient
# @returns:
#  - @httpclient object
# ================================================== -->
sub httpclient
{
    my ( $self, $timeout ) = @_;

    if ( $self->{ 'httpclient' } )
    {
        return $self->{ 'httpclient' };
    }

    $self->{ 'httpclient' } = LWP::UserAgent->new(
        agent      => "Noxu Agent / v1.0",
        conn_cache => LWP::ConnCache->new( total_capacity => 2 ),
        timeout    => ( $timeout ) ? $timeout : 9999,
        ssl_opts   => { verify_hostname => 0 },
        cookie_jar => HTTP::Cookies->new()
    );

    return $self->{ 'httpclient' };
}

# ================================================== -->
# path
# @description: gets the aboslute pathname for a file
# @params:
#  - @scalar: absolute/relative path
# @returns:
#  - @scalar: absolute path
# ================================================== -->
sub path
{
    return io( $_[ 1 ] )->absolute->pathname;
}

1;
