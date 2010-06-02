
#ifdef __cplusplus
extern "C" {
#endif

#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#ifdef __cplusplus
}
#endif

#ifdef vform
#undef vform
#endif

#include <protocol/TBinaryProtocol.h>
#include <transport/TSocket.h>
#include <transport/TTransportUtils.h>

/*
#include <libcassandra/libgenthrift/Cassandra.h>
#include <libcassandra/libgenthrift/cassandra_types.h>
#include <libcassandra/libcassandra/cassandra.h>
#include <libcassandra/libcassandra/keyspace.h>
*/
#include <libgenthrift/Cassandra.h>
#include <libgenthrift/cassandra_types.h>
#include <libcassandra/cassandra.h>
#include <libcassandra/keyspace.h>

#include "ppport.h"

using namespace apache::thrift;
using namespace apache::thrift::protocol;
using namespace apache::thrift::transport;

using namespace std;
using namespace org::apache::cassandra;
using namespace libcassandra;

typedef set<string> StringSet;
typedef StringSet::iterator StringSetIt;

typedef map<string, string> StringMap;
typedef StringMap::iterator StringMapIt;

typedef vector<Column> ColumnVector;
typedef ColumnVector::iterator ColumnVectorIt;

typedef vector<ColumnOrSuperColumn> ColumnOrSuperColumnVector;
typedef ColumnOrSuperColumnVector::iterator ColumnOrSuperColumnVectorIt;

MODULE = Net::Cassandra::libcassandra	PACKAGE = Net::Cassandra::libcassandra PREFIX=xs_cassandra_
##

Cassandra *
xs_cassandra_new(const string in_host, int in_port)
CODE:
  boost::shared_ptr<TTransport> socket(new TSocket(in_host, in_port));
  boost::shared_ptr<TTransport> transport;
  transport= boost::shared_ptr<TTransport> (new TBufferedTransport(socket));
  boost::shared_ptr<TProtocol> protocol(new TBinaryProtocol(transport));

  CassandraClient *client= new(std::nothrow) CassandraClient(protocol);

  transport->open(); /* throws an exception */

  char *CLASS = "Net::Cassandra::libcassandra";
  RETVAL = new Cassandra(client, in_host, in_port);
OUTPUT:
  RETVAL

string
Cassandra::getClusterName()

StringSet
Cassandra::getKeyspaces()

StringMap
Cassandra::getTokenMap(bool fresh)

Keyspace *
Cassandra::getKeyspace(const string name)
CODE:
  char *CLASS = "Net::Cassandra::libcassandra::Keyspace";
  RETVAL = THIS->getKeyspace(name);
OUTPUT:
  RETVAL

void
xs_cassandra_keyspace_insertColumn(Keyspace *ks, const string key, const string column_family, const string super_column_name, const string column_name, const string value)
CODE:
  ks->insertColumn(key, column_family, super_column_name, column_name, value);

void
xs_cassandra_keyspace_insertColumn2(Keyspace *ks, const string key, const string column_family, const string column_name, const string value)
CODE:
  ks->insertColumn(key, column_family, column_name, value);

void
xs_cassandra_keyspace_remove(Keyspace *ks, const string key, const ColumnPath *col_path)
CODE:
  ks->remove(key, *col_path);

void
xs_cassandra_keyspace_remove2(Keyspace *ks, const string key, const string column_family, const string super_column_name, const string column_name)
CODE:
  ks->remove(key, column_family, super_column_name, column_name);

void
xs_cassandra_keyspace_removeColumn(Keyspace *ks, const string key, const string column_family, const string super_column_name, const string column_name)
CODE:
  ks->remove(key, column_family, super_column_name, column_name);

void
xs_cassandra_keyspace_removeSuperColumn(Keyspace *ks, const string key, const string column_family, const string super_column_name)
CODE:
  ks->remove(key, column_family, super_column_name, "");

Column *
xs_cassandra_keyspace_getColumn(Keyspace *ks, const string key, const string column_family, const string super_column_name, const string column_name)
CODE:
  char *CLASS = "Net::Cassandra::libcassandra::Column";
  RETVAL = &(ks->getColumn(key, column_family, super_column_name, column_name));
OUTPUT:
  RETVAL

Column *
xs_cassandra_keyspace_getColumn2(Keyspace *ks, const string key, const string column_family, const string column_name)
CODE:
  char *CLASS = "Net::Cassandra::libcassandra::Column";
  RETVAL = &(ks->getColumn(key, column_family, "", column_name));
OUTPUT:
  RETVAL

string
xs_cassandra_keyspace_getColumnValue(Keyspace *ks, const string key, const string column_family, const string super_column_name, const string column_name)
CODE:
  RETVAL = ks->getColumnValue(key, column_family, super_column_name, column_name);
OUTPUT:
  RETVAL

string
xs_cassandra_keyspace_getColumnValue2(Keyspace *ks, const string key, const string column_family, const string column_name)
CODE:
  RETVAL = ks->getColumnValue(key, column_family, column_name);
OUTPUT:
  RETVAL

SuperColumn *
xs_cassandra_keyspace_getSuperColumn(Keyspace *ks, const string key, const string column_family, const string super_column_name)
CODE:
  char *CLASS = "Net::Cassandra::libcassandra::SuperColumn";
  RETVAL = &(ks->getSuperColumn(key, column_family, super_column_name));
OUTPUT:
  RETVAL

ColumnVector
xs_cassandra_keyspace_getSliceNames(Keyspace *ks, const string key, const ColumnParent *col_parent, SlicePredicate *pred)
CODE:
  RETVAL = ks->getSliceNames(key, *col_parent, *pred);
OUTPUT:
  RETVAL

ColumnVector
xs_cassandra_keyspace_getSliceRange(Keyspace *ks, const string key, const ColumnParent *col_parent, SlicePredicate *pred)
CODE:
  RETVAL = ks->getSliceRange(key, *col_parent, *pred);
OUTPUT:
  RETVAL

int
xs_cassandra_keyspace_getCount(Keyspace *ks, const string key, const ColumnParent *col_parent)
CODE:
  RETVAL = ks->getCount(key, *col_parent);
OUTPUT:
  RETVAL

string
xs_cassandra_keyspace_getName(Keyspace *ks)
CODE:
  RETVAL = ks->getName();
OUTPUT:
  RETVAL
