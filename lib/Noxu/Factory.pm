package Noxu::Factory;

use Object::Tiny;
use Module::Load qw( autoload );
use Module::Load::Conditional qw( check_install );

# ================================================== -->
# instantiate
# @description: the plugin factory method to load the plugin class
# @params:
#  - @scalar: type - reference to type of plugin
# @returns:
#  - reference to loaded class
# ================================================== -->
sub instantiate
{

    my ( $self, $type ) = @_;

    my $plugin = ( check_install( module => "Noxu::$type" ) ) ? "Noxu::$type" : "Noxu::Noop";

    my $key = 'plugin_' . lc $type;

    if ( defined $self->{ $key } )
    {
        return $self->{ $key };
    }

    autoload $plugin;

    $self->{ $key } = $plugin->new();

    return $self->{ $key };
}

sub DESTROY
{
    my ( $self ) = @_;
    if ( defined->{ 'plugin_execute' } )
    {
        $self->{ $key }->cleanup();
    }

}

1;
