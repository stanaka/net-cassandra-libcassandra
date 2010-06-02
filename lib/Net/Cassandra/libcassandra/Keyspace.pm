package Net::Cassandra::libcassandra::Keyspace;

use 5.008008;
use strict;
use warnings;
use Net::Cassandra::libcassandra;

sub insertColumn {
    my ($self, $key, $cf, $scn, $cn, $value) = @_;
    unless($value){
        Net::Cassandra::libcassandra::keyspace_insertColumn2($self, $key, $cf, $scn, $cn);
    } else {
        Net::Cassandra::libcassandra::keyspace_insertColumn($self, $key, $cf, $scn, $cn, $value);
    }
}

sub remove {
    my ($self, $key, $cf, $scn, $cn) = @_;
    unless($cn){
        Net::Cassandra::libcassandra::keyspace_remove($self, $key, $cf);
    } else {
        Net::Cassandra::libcassandra::keyspace_remove2($self, $key, $cf, $scn, $cn);
    }
}

sub removeColumn {
    my ($self, $key, $cf, $scn, $cn) = @_;
    Net::Cassandra::libcassandra::keyspace_removeColumn($self, $key, $cf, $scn, $cn);
}

sub removeSuperColumn {
    my ($self, $key, $cf, $scn) = @_;
    Net::Cassandra::libcassandra::keyspace_removeSuperColumn($self, $key, $cf, $scn);
}

sub getColumn {
    my ($self, $key, $cf, $scn, $cn) = @_;
    unless($cn){
        Net::Cassandra::libcassandra::keyspace_getColumn2($self, $key, $cf, $scn);
    } else {
        Net::Cassandra::libcassandra::keyspace_getColumn($self, $key, $cf, $scn, $cn);
    }
}

sub getColumnValue {
    my ($self, $key, $cf, $scn, $cn) = @_;
    unless($cn){
        Net::Cassandra::libcassandra::keyspace_getColumnValue2($self, $key, $cf, $scn);
    } else {
        Net::Cassandra::libcassandra::keyspace_getColumnValue($self, $key, $cf, $scn, $cn);
    }
}

sub getSuperColumn {
    my ($self, $key, $cf, $scn) = @_;
    Net::Cassandra::libcassandra::keyspace_getSuperColumn($self, $key, $cf, $scn);
}

sub getSliceNames {
    my ($self, $key, $col_parent, $pred) = @_;
    Net::Cassandra::libcassandra::keyspace_getSliceNames($self, $key, $col_parent, $pred);
}

sub getSliceRange {
    my ($self, $key, $col_parent, $pred) = @_;
    Net::Cassandra::libcassandra::keyspace_getSliceRange($self, $key, $col_parent, $pred);
}

sub getCount {
    my ($self, $key, $col_parent) = @_;
    Net::Cassandra::libcassandra::keyspace_getCount($self, $key, $col_parent);
}

sub getName {
    my ($self) = @_;
    Net::Cassandra::libcassandra::keyspace_getName($self);
}

1;
