
# sandbox.hive

Hive playground with [Plural Sight](https://app.pluralsight.com/library/courses/hive-relational-database-developers-getting-started/transcript) following along with Janani Ravi.

Playground notes during the course.

# Installations
Installed both Hadoop and Hive directly as follows
## Hadoop
Followed [site](https://blog.contactsunny.com/data-science/installing-hadoop-on-the-new-m1-pro-and-m1-max-macbook-pro) on local installation on mac book and setting on local path.

Commands to be aware of:
```bash
#  Formatting HDFS name node
hdfs namenode -format
# Start
start-all.sh
# Stop
stop-all.sh
# Test
hdfs dfs -ls /
```

## Hive
[Site](https://cwiki.apache.org/confluence/display/Hive/GettingStarted#GettingStarted-InstallationandConfiguration) to install hive locally.

Hive configuration modifications:  ./conf/hive-site.xml (from template)

* ConnectionURL: (metastore path)
```xml
<name>javax.jdo.option.ConnectionURL</name>
<value>jdbc:derby:;databaseName=/Users/kyuen/hive_db/metastore_db;create=true</value>
```
* Replace:   ${system:java.io.tmpdir} >> /Users/kyuen/hive_io
* Replace:   ${system:user.name} >> kyuen 
				
Log Config: ./conf/hive-log4j2.properties (from template)
* property.hive.log.dir = /Users/kyuen/hive_io/kyuen

# Preparations
Preparing Hadoop
```bash
# start hadoop
start-all.sh

# Ensure Hadoop is running: 
#       NodeManager, ResourceManager, NameNode, SecondaryNameNode, Data Node
jps
# Prepare hadoop directories
hadoop fs -mkdir /tmp
hadoop fs -mkdir /user
hadoop fs -mkdir /user/hive
hadoop fs -mkdir /user/hive/warehouse
# permissions
hadoop fs -chmod g+w /tmp
hadoop fs -chmod g+w /user/hive/warehouse
```

Initialize metastore.db for the first time with
```
schematool -initSchema -dbType derby
```

Connecting locally
```bash
beeline -u jdbc:hive2://
show databases;
```

If "No current connection"
```bash
# reconnect
!connect jdbc:hive2://<hiveserver2-hostname-or-ip>:10000/<database-name>
		
# via kerberos
!connect jdbc:hive2://<hiveserver2_hostname>:10001/<database_name>;transportMode=http;httpPath=cliservice;principal=<hive_principal>
			
# local connect
!connect jdbc:hive2://
```
# Creating Pluralsight DB and Tables
One time executions from command line:
```bash
beeline -u jdbc:hive2:// -e "use pluralsight; select * from customers"
```
			
Running from hql files:
* [00-demo.hql](hql/00-demo.hql)
* [01-demo.hql](hql/01-demo.hql)
* [02-demo.hql](hql/02-demo.hql)
* [03-demo.hql](hql/03-demo.hql)
```bash
beeline -u jdbc:hive2:// -f hql/00-demo.hql 
beeline -u jdbc:hive2:// -f hql/01-demo.hql 
beeline -u jdbc:hive2:// -f hql/02-demo.hql 
beeline -u jdbc:hive2:// -f hql/03-demo.hql 
```
Exploring the warehouse directories with hadoop fs
```bash
# shows the db stored in HDFS
hadoop fs -ls /user/hive/warehouse
# shows the tables in HDFS
hadoop fs -ls /user/hive/warehouse/pluralsight.db
# shows files of the tables
hadoop fs -ls /user/hive/warehouse/pluralsight.db/customers
# Content of the stored file - in this case the first insert into customer
hadoop fs -cat /user/hive/warehouse/pluralsight.db/customers/000000_0
# Content of the second insert
hadoop fs -cat /user/hive/warehouse/pluralsight.db/customers/000000_0_copy_1
```
# External Tables
Preparing data in HDFS
```bash
# creating the data directory
hadoop fs -mkdir /data
# copy the data file to HDFS data directory
hadoop fs -copyFromLocal -f data/products.csv /data/
# confirm file copied
hadoop fs -ls /data/
```

Load data into Hive with [04-demo.hql](hql/04-demo.hql)
```bash
beeline -u jdbc:hive2:// -f hql/04-demo.sql 
```
# Altering Tables
Review [05-demo.hql](hql/05-demo.hql) for content
```bash
beeline -u jdbc:hive2:// -f hql/05-demo.hql 
```

# Temporary Tables
[06-demo.hql](hql/06-demo.hql)
```bash
beeline -u jdbc:hive2:// -f hql/06-demo.hql 
```

# Loading Data into Tables
External file: [freshproducts.csv](data/freshproducts.csv)
## File from local file system
[07a-demo.hql](hql/07a-demo.hql)
```bash
beeline -u jdbc:hive2:// -f hql/07a-demo.hql 
```

Viewing hive warehouse a fresh copy is stored
```bash
# show files in warehouse
hadoop fs -ls /user/hive/warehouse/pluralsight.db/freshproducts
# notice file is an exact copy of local file
hadoop fs -cat /user/hive/warehouse/pluralsight.db/freshproducts/freshproducts.csv
```

## File from HDFS
```bash
# copy file onto HDFS
hadoop fs -copyFromLocal data/freshproducts.csv /data/
# confirm
hadoop fs -ls /data/
```

[07b-demo.hql](hql/07b-demo.hql)
```bash
# run 
beeline -u jdbc:hive2:// -f hql/07b-demo.hql 
```

```bash
# observe that loaded file shows up under HDFS as another copy
hadoop fs -ls /user/hive/warehouse/pluralsight.db/freshproducts/
# observe that the file have moved from data to warehouse directory
hadoop fs -ls /data/
```

## From another Table

[07c-demo.hql](hql/07c-demo.hql)

```bash
# run
beeline -u jdbc:hive2:// -f hql/07c-demo.hql 
```

# Multi-table Insert and Deleting
[08-demo.hql](hql/08-demo.hql)

```bash
# run
beeline -u jdbc:hive2:// -f hql/08-demo.hql 
```
# Data Types
## Arrays
[09a-demo.hql](hql/09a-demo.hql)

```bash
# run
beeline -u jdbc:hive2:// -f hql/09a-demo.hql
```
## Maps
[09b-demo.hql](hql/09b-demo.hql)

```bash
beeline -u jdbc:hive2:// -f hql/09b-demo.hql
```
## Struct
[09c-demo.hql](hql/09c-demo.hql)

```bash
beeline -u jdbc:hive2:// -f hql/09c-demo.hql
```
## Table Functions and Lateral Views
[09d-demo.hql](hql/09d-demo.hql)

```bash
beeline -u jdbc:hive2:// -f hql/09d-demo.hql
```

# Subqueries and Views
[10a-demo.hql](hql/10a-demo.hql)

```bash
beeline -u jdbc:hive2:// -f hql/10a-demo.hql
```


# Cleanup
```bash
# shutdown hadoop
stop-all.sh
```