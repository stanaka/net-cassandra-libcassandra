package Net::Cassandra::libcassandra;

use 5.008008;
use strict;
use warnings;
use Net::Cassandra::libcassandra::Keyspace;

require Exporter;

our @ISA = qw(Exporter);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration	use Net::Cassandra::libcassandra ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.
our %EXPORT_TAGS = ( 'all' => [ qw(
	
) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
	
);

our $VERSION = '0.01';

require XSLoader;
XSLoader::load('Net::Cassandra::libcassandra', $VERSION);

# Preloaded methods go here.

1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

Net::Cassandra::libcassandra - Perl binding for Cassandra with libcassandra.

=head1 SYNOPSIS

  use Net::Cassandra::libcassandra;

  my $cassandra = Net::Cassandra::libcassandra::new('localhost', 9160);

  warn $cassandra->getClusterName();
  warn $cassandra->getKeyspaces();
  warn $cassandra->getTokenMap(0);

  my $keyspace = $cassandra->getKeyspace("Keyspace1");
  warn $keyspace->getName();
  $keyspace->insertColumn("aa", "Standard1", "cc", "dd");

  my $res = $keyspace->getColumnValue("aa", "Standard1", "cc");
  warn "Value in column retrieved is: ". $res;

=head1 DESCRIPTION

This module provides a Perl interface to Cassandra via libcassandra.
It uses XS for communicating with libcassandra.

=head1 SEE ALSO

Net::Cassandra, Net::Cassandra::Easy

=head1 AUTHOR

Shinji Tanaka <shinji.tanaka@gmail.com>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2010 by Shinji Tanaka

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.8 or,
at your option, any later version of Perl 5 you may have available.

=cut
