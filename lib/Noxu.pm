############################################################
# @package:         Noxu
# @description:     A general purpose Builder
# @version:         v1.0
# @author:          Crazy Camel
############################################################
package Noxu;

use 5.026001;
use utf8;
use strict;
use warnings;

use Object::Tiny qw/script base/;

use YAML::Tiny;
use IO::All -utf8;

use Noxu::Factory;

sub build
{
    my ( $self, $buildfile ) = @_;

    my $factory = Noxu::Factory->new();

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

sub parse
{

    my ( $self, $build ) = @_;

    my $factory = Noxu::Factory->new();
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

# Preloaded methods go here.

1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

Noxu - Perl extension for a bare bones YAML build system

=head1 SYNOPSIS

  use Noxu;
  
  my $noxu = new Noxu;

  my $filename = "build.yml" # filename of build file

  $noxu->build( $filename );

=head1 DESCRIPTION

A simplistic bare bone YAML based build system

=head2 EXPORT

None by default.

=head1 AUTHOR

Xerocole, E<lt>development@crazycamel.caE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2018 by Crazy Camel

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.26.1 or,
at your option, any later version of Perl 5 you may have available.


=cut
