############################################################
# @package:         Noxu::Assemble
# @description:     A general purpose Builder
# @version:         v1.0
# @author:          Crazy Camel
############################################################
package Noxu::Assemble;

use utf8;
use strict;
use warnings;

use Object::Tiny qw/script base/;
use YAML::Tiny;
use IO::All -utf8;

use Noxu::Plugin::Factory;

sub build
{
    my ( $self, $buildfile ) = @_;

    my $factory = new Noxu::Plugin::Factory;

    my $filename = io( $buildfile )->absolute->pathname;

    my $build = YAML::Tiny->read( $filename );

    # ------------------------------------

    my $targets = scalar @$build;

    for ( my $idx = 0; $idx < $targets; $idx++ )
    {
        my $instructions = $build->[ $idx ];

        foreach my $task ( @$instructions )
        {
            my $action = ucfirst $task->{ 'action' };

            $factory->instantiate( $action )->handle( $task );

        }
    }

    # ------------------------------------

    return $self;
}

1;
