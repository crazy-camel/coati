package Noxu::Plugin::Banner;

use parent 'Noxu::Plugin::Base';

# ================================================== -->
# banner
# @description: the plugin handler
# @params:
#  - @scalar: task
# @returns:
#  - reference to self for chaining
# ================================================== -->
sub execute
{
    my ( $self, $task ) = @_;

    print $self->border( $task );
    print $self->line( $task->{ 'title' } )    if ( defined $task->{ 'title' } );
    print $self->line( $task->{ 'subtitle' } ) if ( defined $task->{ 'subtitle' } );
    print $self->line( $task->{ 'message' } )  if ( defined $task->{ 'message' } );
    print $self->border( $task );
    return $self;
}

sub border
{
    my ( $self, $task ) = @_;
    my $output = ( defined $task->{ 'border' } ) ? $task->{ 'border' } x 80 : '=' x 80;
    return "$output\n";
}

sub line
{
    my ( $self, $message ) = @_;
    return "   $message\n";
}

1;
