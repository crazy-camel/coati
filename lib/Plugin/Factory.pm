package Noxu::Plugin::Factory;

use Object::Tiny;
use Module::Load 'autoload';


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

    if ( defined $self->{ 'plugin_' . $type } )
    {
        return $self->{ 'plugin_' . $type };
    }

    my $plugin = "Noxu::Plugin::$type";

    autoload $plugin;

    $self->{ 'plugin_' . $type } = $plugin->new();

    return $self->{ 'plugin_' . $type };
}

1;
