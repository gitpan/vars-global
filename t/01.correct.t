# vim: filetype=perl :
use strict;
use warnings;

use Test::More tests => 2; # last test to print

use vars::global create => qw( $foo @bar %baz );

my $lexfoo = 'ciao';
my @lexbar = qw( a tutti );
my %lexbaz = map { $_ => 1 } @lexbar;
my $lexstring = join '/', $lexfoo, @lexbar, keys %lexbaz, values %lexbaz;

eval {
    $foo = $lexfoo;
    @bar = @lexbar;
    %baz = map { $_ => 1 } @bar;

    # Just to be sure... after this, $foo and $lexfoo will have different
    # values
    $lexfoo = '';
    @lexbar = ();
    
    my $string = join '/', $foo, @bar, keys %baz, values %baz;
    is($string, $lexstring, 'values are correct');
};

is($@, '', 'usage of declared variables');
