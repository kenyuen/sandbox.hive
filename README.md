# sandbox.hive
Hive playground with Plural Sight.

# Basic commands

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

One time executions from command line:
```bash
beeline -u jdbc:hive2:// -e "use pluralsight; select * from customers"
```
			
Running from hql file:
```bash
beeline -u jdbc:hive2:// -f hql/01-customers.hql
beeline -u jdbc:hive2:// -f hql/02-orders.hql
```

