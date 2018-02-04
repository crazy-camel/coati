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

    if ( defined $self->{ 'plugin_' . $type } )
    {
        return $self->{ 'plugin_' . $type };
    }
   
    autoload $plugin;

    $self->{ 'plugin_' . $type } = $plugin->new();

    return $self->{ 'plugin_' . $type };
}

1;
