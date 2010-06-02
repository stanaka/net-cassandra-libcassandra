use lib qw(./lib ./blib/arch/auto/Net/Cassandra/libcassandra);
use Net::Cassandra::libcassandra;
use Data::Dumper;

my $cassandra = Net::Cassandra::libcassandra::new('localhost', 9160);

warn $cassandra->getClusterName();
warn Data::Dumper::Dumper($cassandra->getKeyspaces());
warn Data::Dumper::Dumper($cassandra->getTokenMap(0));

my $keyspace = $cassandra->getKeyspace("Keyspace1");
warn $keyspace->getName();
$keyspace->insertColumn("key", "Standard1", "", "name", "value");

my $res = $keyspace->getColumnValue("key", "Standard1", "", "name");
warn "Value in column retrieved is: ". $res;

$keyspace->remove("key", "Standard1", "", "name");
warn "deleted";

eval {
    $res = $keyspace->getColumnValue("key", "Standard1", "name");
    warn "Value in column retrieved is: ". $res;
};
warn $@ if $@;


