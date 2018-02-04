# Before 'make install' is performed this script should be runnable with
# 'make test'. After 'make install' it should work as 'perl Noxu.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use strict;
use warnings;

use Test::More;
use YAML::Tiny;
use Noxu;

plan tests => 3;

{
	my $noxu = Noxu->new();

	my $title = [ [ { action => 'banner', title => 'abcdefghijklmnopqrstuvwxyz' } ] ];
	is( counter( $noxu, $title ) , 192, "Banner - Title test" );

	my $subtitle = [ [ { action => 'banner', title => 'abcdefghijklmnopqrstuvwxyz', subtitle => 'abcde' } ] ];
	is( counter( $noxu, $subtitle ) , 201, "Banner - Sub title test" );

	my $message = [ [ { action => 'banner', message => 'abcdefghijklmnopqrstuvwxyz' } ] ];
	is( counter( $noxu, $message ) , 192, "Banner - message test" );

}


####################################
sub counter
{
	my ( $noxu, $build, $output ) = @_;

    local *STDOUT;

    open( STDOUT, ">>", \$output );
        
    $noxu->parse( $build );
        
    close( STDOUT );
        
    return length $output;
}