use 5.008008;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME              => 'Net::Cassandra::libcassandra',
    VERSION_FROM      => 'lib/Net/Cassandra/libcassandra.pm', # finds $VERSION
    PREREQ_PM         => {}, # e.g., Module::Name => 1.1
    ($] >= 5.005 ?     ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM  => 'lib/Net/Cassandra/libcassandra.pm', # retrieve abstract from module
       AUTHOR         => 'A. U. Thor <stanaka@osuosl.org>') : ()),
    #LIBS              => ['-lthrift -lcassandra'], # e.g., '-lm'
    LIBS              => ['-lcassandra'], # e.g., '-lm'
    #LIBS              => ['-lthrift'], # e.g., '-lm'
    DEFINE            => '', # e.g., '-DHAVE_SOMETHING'
    INC               => '-I. -I/usr/include/thrift', # e.g., '-I. -I/usr/include/other'
	# Un-comment this if you add C files to link with later:
    # OBJECT            => '$(O_FILES)', # link all the C files too
    CC => '/usr/bin/g++',
    LD => '/usr/bin/g++',
    XSOPT => '-C++',
    TYPEMAPS => ['perlobject.map'],
);

