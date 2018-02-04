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

plan tests => 2;

{
	my $noxu = Noxu->new();

	# ----------------------------------
	# Stage the files for testing
	
 	io( 'tmp.txt ')->touch();

	io( 'tmp' )->mkdir();
	
	io( 'tmp/test.txt' )->touch();

	
	# -----------------------------------
	# Remove the file
	my $removefile = [ [ { action => 'clean', resources => [ 'tmp.txt' ] } ] ];
	
	$noxu->parse( $removefile );

	ok( !io('tmp.txt')->exists(), "Clean - removed file" );

	# ------------------------------------
	# Remove the directory
	my $removedirectory = [ [ { action => 'clean', resources => [ 'tmp' ] } ] ];

	$noxu->parse( $removedirectory );
	
	ok( !io('tmp')->exists(), "Clean - removed directory");


	## Clean up in case there was an error
	
	io('tmp')->rmtree() if io('tmp')->exists();
	io( 'tmp.txt ')->unlink() if io( 'tmp.txt ')->exists();

}
