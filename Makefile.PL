# $Id: Makefile.PL,v 1.4 2002/04/07 14:01:13 scop Exp $

use ExtUtils::MakeMaker;

$| = 1;

print "\n";

print "Checking for Regex::PreSuf...";
eval {
  require Regex::PreSuf;
};
if ($@) {
  print " failed\n";
  print <<EOT;
  Regex::PreSuf is _not_ required.
  But if you had it installed, most gmuck tests would run slightly faster.
EOT
  sleep(2);
} else {
  print "ok\n";
}

print "\n";

WriteMakefile(
              NAME              => 'gmuck',
              VERSION_FROM      => 'bin/gmuck',
              PREREQ_PM         => { 'Getopt::Long' => 0,
                                     'Carp'         => 0,
                                     'HTML::Tagset' => 3.03,
                                   },
              EXE_FILES         => ['bin/gmuck'],
              MAN1PODS          => { 'bin/gmuck.pod' =>
                                     '$(INST_MAN1DIR)/gmuck.$(MAN1EXT)',
                                   },
              ($] >= 5.005 ?
               (ABSTRACT_FROM   => 'bin/gmuck.pod',
                AUTHOR    => 'Ville Skyttä <ville . skytta @ iki . fi>') : ()),

              dist              => { COMPRESS => 'gzip -9f', SUFFIX => 'gz' },
             );

# Stuff below happily stolen from libwww-perl :)

package MY;

# Pass gmuck version to pod2man
sub manifypods
{
  my $self = shift;
  my $ver = $self->{VERSION} || "";
  local($_) = $self->SUPER::manifypods(@_);
  s/pod2man\s*$/pod2man --release gmuck-$ver/m;
  $_;
}
