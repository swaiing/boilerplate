#!/usr/bin/perl -w
#
# basic boilerplate perl script
# which accomplishes some simple tasks:
# accepts arguments, reads a file, runs a command
#
 
# modules
use strict;
use Getopt::Long;
use File::Basename;
 
# print usage
sub usage
{
  print "\n";
  print "  " . basename($0) . " [-f file] [-c cmd] [-z foo]\n";
  print "\n";
}
 
# open file and read line by line 
sub read_file
{
  my $path = $_[0];
  open (FILE, $path);
  while (<FILE>) {
    chomp;
    # skip commented out lines
    if (/^#/) { next; }
    my $line = $_;
    print "line: $line\n";
  }
  close(FILE);
}

# run unix command and regex output
sub run_command
{
  my $cmd = $_[0]; # do nothing with this
  my $out = `df -h . 2> /dev/null`;
  my $p = "";
  if ($out =~ /[^\n]*\n([\S]*\s*){5}([\S]*).*$/) {
    $p = $1;
  }
  return $p;
}
 
# main
my $file;
my $cmd;
my $argZ;

# parse options
GetOptions("f=s"=>\$file,
           "c=s"=>\$cmd,
           "z=s"=>\$argZ);

if (!($file || $cmd || $argZ)) {
    usage();
    exit 1;
}

# call functions
if ($file && -e $file) {
    print "***** read file: \n";
    read_file($file);
    print "\n";
}

if ($cmd) {
    print "***** run command: \n";
    print "current directory file system utilization: " . run_command($cmd) . "\n";
    print "\n";
}

print "***** argument z: $argZ\n" if ($argZ);
 
exit 0;
