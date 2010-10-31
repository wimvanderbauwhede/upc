#!/usr/bin/perl
if (not @ARGV) {
    die "Please specify .slides source file\n";
}
my $slides_src_file=$ARGV[0];
system("perl ./perl-coloriser.pl $slides_src_file > Spork.slides");
system("spork -make");
system("perl ./postproc_slides.pl");
system("spork -start");
