# Before 'make install' is performed this script should be runnable with
# 'make test'. After 'make install' it should work as 'perl Noxu.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use strict;
use warnings;

use Test::More;
use YAML::Tiny;
use Noxu;
use IO::All;

plan tests => 1;

{
	my $noxu = Noxu->new();

	# ----------------------------------
	# Stage the files for testing
	# 
	my $testfile = io( 'tmp.txt ');
	
 	$testfile->append( "Hello World");
	
	# -----------------------------------
	# Remove the file
	my $cfile = [ [ { action => 'clear', resources => [ 'tmp.txt' ] } ] ];
	
	$noxu->parse( $cfile );
	
	is( io( 'tmp.txt ')->size(), 0, "Clear a file test" );

	io( 'tmp.txt ')->unlink();

}
