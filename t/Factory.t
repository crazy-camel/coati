# Before 'make install' is performed this script should be runnable with
# 'make test'. After 'make install' it should work as 'perl Noxu.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use strict;
use warnings;

use Test::More;
use Noxu;
use IO::All;

plan tests => 2;

{
    my $noxu    = Noxu->new();
    my $actions_ran = 0;

    $actions_ran = $noxu->parse(
        [   [   { action => 'banner', message => 'testing' },
                { action => 'banner', message => 'testing' },
                { action => 'banner', message => 'testing' }
            ]
        ]
    );

    is( $actions_ran, 3, "Factory - all known tests" );

    $actions_ran = $noxu->parse(
        [   [   { action => 'banner',  message => 'testing' },
                { action => 'banner2', message => 'testing' },
                { action => 'banner',  message => 'testing' }
            ]
        ]
    );

    is( $actions_ran, 2, "Factory - one unknown test" );

}
