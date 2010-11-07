#!/usr/bin/perl -w
#
# Copyright (c) 2010 by Stephen Wai
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
#
# Description: 
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
