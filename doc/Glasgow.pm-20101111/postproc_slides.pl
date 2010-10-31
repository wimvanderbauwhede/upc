#!/usr/bin/perl
use warnings;
use strict;

chdir "slides";
my $span1='&lt;span class=&#34;';
my $span2='&#34;&gt;';
my $span3='&lt;/span&gt;';
my $br='&lt;br&gt;';
my $keywords='use|my|for|while|sub|if|else|elsif|unless';
my $span_k_o='<span class="key">';
my $span_k_c='</span>';
my @slides=<slide*.html>;
for my $slide (@slides){
system("mv $slide $slide.orig");
open(IN,"<$slide.orig");
open(OUT,">$slide");
while(<IN>) {
/<img/ && do {
s/width\=\"\d+\"//;
s/align\=left//;
};
#if (not /$span1/) {
#s/($keywords)\s/$span_k_o$1$span_k_c /;
#} else {
s/$span1/<span\ class=\"/g;
s/$span2/\">/g;
s/$span3/<\/span>/g;
#}
s/$br/<br>/g;

print OUT $_;
}
close IN;
close OUT;
}
