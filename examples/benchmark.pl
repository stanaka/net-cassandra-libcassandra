package main;

use lib qw(./lib ./blib/arch/auto/Net/Cassandra/libcassandra);
use Net::Cassandra::libcassandra;
use Net::Cassandra::libcassandra::Keyspace;

use Benchmark qw/cmpthese/;
use String::Random;

my $cassandra2 = Net::Cassandra::libcassandra::new('localhost', 9160);
my $keyspace = $cassandra2->getKeyspace("Keyspace1");

use Data::Dumper;
print Data::Dumper::Dumper($keyspace);
print Data::Dumper::Dumper($keyspace->getName());

my $column_family = 'Standard1';
my $column_name = 'rand';

sub exec_cassandra {
    my ($test, $keys, $value) = @_;
    for $_ (@$keys) {
        eval {
            $test->insertColumn($_, $column_family, $column_name, $value);
            $test->getColumnValue($_, $column_family, $column_name);
            $test->getColumnValue($_, $column_family, $column_name);
            $test->getColumnValue($_, $column_family, $column_name);
        };
        warn $@ if $@;
    }
}

foreach my $max ( qw/10 100 1000 10000 100000/ ) {
    foreach my $num ( qw/10 100 1000 10000 100000/ ) {
        print "### keys=$num, length=$max\n";
        my @keys = map { "k" . $_ } 0..$max;
        my $value = String::Random->new->randregex(".{$num}");
        cmpthese(
            $n => +{
                cassandra_xs => sub { exec_cassandra($keyspace, \@keys, $value); },
            }
        );
    }
}
