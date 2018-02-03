#!/usr/bin/env perl

$| = 1;

use v5.22;
use utf8;
use strict;
use warnings;
use Getopt::Long;

use rlib '.';

use File::Basename;
use IO::All -utf8;

use Tusker::Assemble;

my $filename = "tusk.yml";

GetOptions( "file=s" => \$filename )
    or die( "Error in command line arguments\n" );

my $builder = Tusker::Assemble->new();

$builder->build( $filename );
