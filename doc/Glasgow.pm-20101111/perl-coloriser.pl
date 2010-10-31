#!/usr/bin/perl

=info
* Perl code should be indented with 2 spaces minimum.
Code indented with a single space will not be syntax coloured.
* a _ on its own on a line will result in a &nbsp;
=cut

#  Declarations
#=====================================================================
use warnings;
use strict;

use Syntax::Highlight::Perl;

my $color_table = {
    'Variable_Scalar'   => 'var',
    'Variable_Array'    => 'var',
    'Variable_Hash'     => 'var',
    'Variable_Typeglob' => 'var',
    'Subroutine'        => 'var',
    'Quote'             => 'const',
    'String'            => 'const',
    'Comment_Normal'    => 'comm',
    'Comment_POD'       => 'comm' ,
    'Number'            => 'const',
#    'Operator'          => 'plain',
#    'Symbol'            => 'plain', # ({,; etc
    'Keyword'           => 'key',
    'Builtin_Operator'  => 'key',
    'Builtin_Function'  => 'key',
#    'Character'         => 'color:#800;',
    'Directive'         => 'key',
#    'Label'             => 'color:#939;font-style:italic;',
#    'Line'              => 'color:#000;',
};

#  Program proper
#=====================================================================

my $formatter = Syntax::Highlight::Perl->new();

#$formatter->define_substitution('<' => '&lt;', 
#                                '>' => '&gt;', 
#                                '&' => '&amp;'); # HTML escapes.

# install the formats set up above
while ( my ( $type, $style ) = each %{$color_table} ) {

    $formatter->set_format($type, [ qq|<span class="$style">|, 
                                    '</span>' ] );
}

my $pre_block=0;
my $perl_block=0;
while(<>) {

if (/^(=+\s)*_\s*$/) {s/_/<hide>_<\/hide>/;}

s/<br>/__BR__/g;

while (/<([a-z]+)>/ and /<\/$1>/ ) {
    s/<([a-z]+)>/<span class=\"$1\">/;
    s/<\/$1>/<\/span>/;
}
s/__BR__/<br>/g;
if (/^\s\s\S/) {
$perl_block=1;
}
if (/^\S/) {
$perl_block=0;
}
if ($perl_block==1) {
    s/^\s//;
    print $formatter->format_string;
} else {
    print $_;
}
}
#my $file = shift || die "Give me a perl file to colorize!\n";
#-e $file or die "There's no such file: $file\n";

#open F, '<', $file or die $!;

#print '<pre class="formatter_pre">';
#while (<F>) {
#    print $formatter->format_string;
#}
#print "</pre>";
#close F;

#exit 0;
