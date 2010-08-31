
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

  try {
    transport->open(); /* throws an exception */
  } catch (TTransportException &e) {
    croak("TTransportException: %s", e.what());
  } catch (TException &e) {
    croak("TException: %s", e.what());
  }
  const char *CLASS = "Net::Cassandra::libcassandra";
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
  const char *CLASS = "Net::Cassandra::libcassandra::Keyspace";
  RETVAL = THIS->getKeyspace(name);
OUTPUT:
  RETVAL

void
xs_cassandra_keyspace_insertColumn(Keyspace *ks, const string key, const string column_family, const string super_column_name, const string column_name, const string value)
CODE:
  try {
    ks->insertColumn(key, column_family, super_column_name, column_name, value);
  } catch (InvalidRequestException &e) {
    croak("InvalidRequestException: %s", e.what());
  } catch (UnavailableException &e) {
    croak("UnavailableException: %s", e.what());
  } catch (TimedOutException &e) {
    croak("TimedOutException: %s", e.what());
  } catch (TProtocolException &e) {
    croak("TProtocolException: %s", e.what());
  } catch (NotFoundException &e) {
    croak("NotFoundException: %s", e.what());
  } catch (TException &e) {
    croak("TException: %s", e.what());
  }

void
xs_cassandra_keyspace_insertColumn2(Keyspace *ks, const string key, const string column_family, const string column_name, const string value)
CODE:
  try {
    ks->insertColumn(key, column_family, column_name, value);
  } catch (InvalidRequestException &e) {
    croak("InvalidRequestException: %s", e.what());
  } catch (UnavailableException &e) {
    croak("UnavailableException: %s", e.what());
  } catch (TimedOutException &e) {
    croak("TimedOutException: %s", e.what());
  } catch (TProtocolException &e) {
    croak("TProtocolException: %s", e.what());
  } catch (NotFoundException &e) {
    croak("NotFoundException: %s", e.what());
  } catch (TException &e) {
    croak("TException: %s", e.what());
  }

void
xs_cassandra_keyspace_remove(Keyspace *ks, const string key, const ColumnPath *col_path)
CODE:
  try {
    ks->remove(key, *col_path);
  } catch (InvalidRequestException &e) {
    croak("InvalidRequestException: %s", e.what());
  } catch (UnavailableException &e) {
    croak("UnavailableException: %s", e.what());
  } catch (TimedOutException &e) {
    croak("TimedOutException: %s", e.what());
  } catch (TProtocolException &e) {
    croak("TProtocolException: %s", e.what());
  } catch (NotFoundException &e) {
    croak("NotFoundException: %s", e.what());
  } catch (TException &e) {
    croak("TException: %s", e.what());
  }

void
xs_cassandra_keyspace_remove2(Keyspace *ks, const string key, const string column_family, const string super_column_name, const string column_name)
CODE:
  try {
    ks->remove(key, column_family, super_column_name, column_name);
  } catch (InvalidRequestException &e) {
    croak("InvalidRequestException: %s", e.what());
  } catch (UnavailableException &e) {
    croak("UnavailableException: %s", e.what());
  } catch (TimedOutException &e) {
    croak("TimedOutException: %s", e.what());
  } catch (TProtocolException &e) {
    croak("TProtocolException: %s", e.what());
  } catch (NotFoundException &e) {
    croak("NotFoundException: %s", e.what());
  } catch (TException &e) {
    croak("TException: %s", e.what());
  }

void
xs_cassandra_keyspace_removeColumn(Keyspace *ks, const string key, const string column_family, const string super_column_name, const string column_name)
CODE:
  try {
    ks->remove(key, column_family, super_column_name, column_name);
  } catch (InvalidRequestException &e) {
    croak("InvalidRequestException: %s", e.what());
  } catch (UnavailableException &e) {
    croak("UnavailableException: %s", e.what());
  } catch (TimedOutException &e) {
    croak("TimedOutException: %s", e.what());
  } catch (TProtocolException &e) {
    croak("TProtocolException: %s", e.what());
  } catch (NotFoundException &e) {
    croak("NotFoundException: %s", e.what());
  } catch (TException &e) {
    croak("TException: %s", e.what());
  }

void
xs_cassandra_keyspace_removeSuperColumn(Keyspace *ks, const string key, const string column_family, const string super_column_name)
CODE:
  try {
    ks->remove(key, column_family, super_column_name, "");
  } catch (InvalidRequestException &e) {
    croak("InvalidRequestException: %s", e.what());
  } catch (UnavailableException &e) {
    croak("UnavailableException: %s", e.what());
  } catch (TimedOutException &e) {
    croak("TimedOutException: %s", e.what());
  } catch (TProtocolException &e) {
    croak("TProtocolException: %s", e.what());
  } catch (NotFoundException &e) {
    croak("NotFoundException: %s", e.what());
  } catch (TException &e) {
    croak("TException: %s", e.what());
  }

Column *
xs_cassandra_keyspace_getColumn(Keyspace *ks, const string key, const string column_family, const string super_column_name, const string column_name)
CODE:
  const char *CLASS = "Net::Cassandra::libcassandra::Column";
  try {
    RETVAL = &(ks->getColumn(key, column_family, super_column_name, column_name));
  } catch (InvalidRequestException &e) {
    croak("InvalidRequestException: %s", e.what());
  } catch (UnavailableException &e) {
    croak("UnavailableException: %s", e.what());
  } catch (TimedOutException &e) {
    croak("TimedOutException: %s", e.what());
  } catch (TProtocolException &e) {
    croak("TProtocolException: %s", e.what());
  } catch (NotFoundException &e) {
    croak("NotFoundException: %s", e.what());
  } catch (TException &e) {
    croak("TException: %s", e.what());
  }
OUTPUT:
  RETVAL

Column *
xs_cassandra_keyspace_getColumn2(Keyspace *ks, const string key, const string column_family, const string column_name)
CODE:
  const char *CLASS = "Net::Cassandra::libcassandra::Column";
  try {
    RETVAL = &(ks->getColumn(key, column_family, "", column_name));
  } catch (InvalidRequestException &e) {
    croak("InvalidRequestException: %s", e.what());
  } catch (UnavailableException &e) {
    croak("UnavailableException: %s", e.what());
  } catch (TimedOutException &e) {
    croak("TimedOutException: %s", e.what());
  } catch (TProtocolException &e) {
    croak("TProtocolException: %s", e.what());
  } catch (NotFoundException &e) {
    croak("NotFoundException: %s", e.what());
  } catch (TException &e) {
    croak("TException: %s", e.what());
  }
OUTPUT:
  RETVAL

string
xs_cassandra_keyspace_getColumnValue(Keyspace *ks, const string key, const string column_family, const string super_column_name, const string column_name)
CODE:
  try {
    RETVAL = ks->getColumnValue(key, column_family, super_column_name, column_name);
  } catch (InvalidRequestException &e) {
    croak("InvalidRequestException: %s", e.what());
  } catch (UnavailableException &e) {
    croak("UnavailableException: %s", e.what());
  } catch (TimedOutException &e) {
    croak("TimedOutException: %s", e.what());
  } catch (TProtocolException &e) {
    croak("TProtocolException: %s", e.what());
  } catch (NotFoundException &e) {
    croak("NotFoundException: %s", e.what());
  } catch (TException &e) {
    croak("TException: %s", e.what());
  }
OUTPUT:
  RETVAL

string
xs_cassandra_keyspace_getColumnValue2(Keyspace *ks, const string key, const string column_family, const string column_name)
CODE:
  try {
    RETVAL = ks->getColumnValue(key, column_family, column_name);
  } catch (InvalidRequestException &e) {
    croak("InvalidRequestException: %s", e.what());
  } catch (UnavailableException &e) {
    croak("UnavailableException: %s", e.what());
  } catch (TimedOutException &e) {
    croak("TimedOutException: %s", e.what());
  } catch (TProtocolException &e) {
    croak("TProtocolException: %s", e.what());
  } catch (NotFoundException &e) {
    croak("NotFoundException: %s", e.what());
  } catch (TException &e) {
    croak("TException: %s", e.what());
  }
OUTPUT:
  RETVAL

SuperColumn *
xs_cassandra_keyspace_getSuperColumn(Keyspace *ks, const string key, const string column_family, const string super_column_name)
CODE:
  char *CLASS = "Net::Cassandra::libcassandra::SuperColumn";
  try {
    RETVAL = &(ks->getSuperColumn(key, column_family, super_column_name));
  } catch (InvalidRequestException &e) {
    croak("InvalidRequestException: %s", e.what());
  } catch (UnavailableException &e) {
    croak("UnavailableException: %s", e.what());
  } catch (TimedOutException &e) {
    croak("TimedOutException: %s", e.what());
  } catch (TProtocolException &e) {
    croak("TProtocolException: %s", e.what());
  } catch (NotFoundException &e) {
    croak("NotFoundException: %s", e.what());
  } catch (TException &e) {
    croak("TException: %s", e.what());
  }
OUTPUT:
  RETVAL

ColumnVector
xs_cassandra_keyspace_getSliceNames(Keyspace *ks, const string key, const ColumnParent *col_parent, SlicePredicate *pred)
CODE:
  try {
    RETVAL = ks->getSliceNames(key, *col_parent, *pred);
  } catch (InvalidRequestException &e) {
    croak("InvalidRequestException: %s", e.what());
  } catch (UnavailableException &e) {
    croak("UnavailableException: %s", e.what());
  } catch (TimedOutException &e) {
    croak("TimedOutException: %s", e.what());
  } catch (TProtocolException &e) {
    croak("TProtocolException: %s", e.what());
  } catch (NotFoundException &e) {
    croak("NotFoundException: %s", e.what());
  } catch (TException &e) {
    croak("TException: %s", e.what());
  }
OUTPUT:
  RETVAL

ColumnVector
xs_cassandra_keyspace_getSliceRange(Keyspace *ks, const string key, const ColumnParent *col_parent, SlicePredicate *pred)
CODE:
  try {
    RETVAL = ks->getSliceRange(key, *col_parent, *pred);
  } catch (InvalidRequestException &e) {
    croak("InvalidRequestException: %s", e.what());
  } catch (UnavailableException &e) {
    croak("UnavailableException: %s", e.what());
  } catch (TimedOutException &e) {
    croak("TimedOutException: %s", e.what());
  } catch (TProtocolException &e) {
    croak("TProtocolException: %s", e.what());
  } catch (NotFoundException &e) {
    croak("NotFoundException: %s", e.what());
  } catch (TException &e) {
    croak("TException: %s", e.what());
  }
OUTPUT:
  RETVAL

int
xs_cassandra_keyspace_getCount(Keyspace *ks, const string key, const ColumnParent *col_parent)
CODE:
  try {
    RETVAL = ks->getCount(key, *col_parent);
  } catch (InvalidRequestException &e) {
    croak("InvalidRequestException: %s", e.what());
  } catch (UnavailableException &e) {
    croak("UnavailableException: %s", e.what());
  } catch (TimedOutException &e) {
    croak("TimedOutException: %s", e.what());
  } catch (TProtocolException &e) {
    croak("TProtocolException: %s", e.what());
  } catch (NotFoundException &e) {
    croak("NotFoundException: %s", e.what());
  } catch (TException &e) {
    croak("TException: %s", e.what());
  }
OUTPUT:
  RETVAL

string
xs_cassandra_keyspace_getName(Keyspace *ks)
CODE:
  try {
    RETVAL = ks->getName();
  } catch (InvalidRequestException &e) {
    croak("InvalidRequestException: %s", e.what());
  } catch (UnavailableException &e) {
    croak("UnavailableException: %s", e.what());
  } catch (TimedOutException &e) {
    croak("TimedOutException: %s", e.what());
  } catch (TProtocolException &e) {
    croak("TProtocolException: %s", e.what());
  } catch (NotFoundException &e) {
    croak("NotFoundException: %s", e.what());
  } catch (TException &e) {
    croak("TException: %s", e.what());
  }
OUTPUT:
  RETVAL
