package test::Net::Cassandra::libcassandra;
use strict;
use warnings;
use base qw(Test::Class);
use Path::Class;
use lib file(__FILE__)->dir->subdir('lib')->stringify;

use Test::More tests => 4;

my $cassnadra;

sub _use: Test(1) {
    use_ok 'Net::Cassandra::libcassandra'
}

sub test_connect : Test {
    my $self = shift;
    $self->{cassandra} = Net::Cassandra::libcassandra::new('localhost', 9160);
    isa_ok($self->{cassandra}, 'Net::Cassandra::libcassandra');
}



sub test_connect_to_nonexist_server : Test {
    my $cassandra_non;
    eval {
        $cassandra_non = Net::Cassandra::libcassandra::new('localhost', 9161);
    };
    warn $@ if $@;
    is($cassandra_non, undef);
}

sub test_get_nonexist_column : Test {
    my $self = shift;
    my $keyspace = $self->{cassandra}->getKeyspace("Keyspace1");

    eval {
        $keyspace->getColumnValue("key", "Standard1", "", "not_exist_column");
    };
    warn $@ if $@;
}

__PACKAGE__->runtests;

1;
