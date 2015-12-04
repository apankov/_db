_db
===

Simple set of MySQL cli tools. Docker ready.


Initialization
--------------

Copy `_db` into some place (usually inside your project directory) or clone it from GitHub:

    git clone https://github.com/apankov/_db.git

Create config for the tools by copying provided default config `db.conf.example` into `db.conf`

    cp db.conf.example db.conf

Update config by substituting your credentials.


Docker
------

If your MySQL server is running inside Docker container, you have to specify container name, for instance:
`DOCKER_MYSQLD_CONTAINER=mysqld`

It could be helpful to use MySQL server host address, port and root's password defined by environmental variables in the container. To do so one can use following params in config file `db.conf`:

    DBHOST='$MYSQL_PORT_3306_TCP_ADDR'
    DBPORT='$MYSQL_PORT_3306_TCP_PORT'
    DBPASS='$MYSQL_ENV_MYSQL_ROOT_PASSWORD'


Tools description
-----------------

* `dbreset.sh` - drops database, creates new one, applies dump file passed as first argument; if dump file is missed, `dump.sql` used instead

* `dbconsole.sh` - opens mysql console

* `dbpatch.sh` - applies patch specified as first argument

* `dbdump.sh` - calls `mysqldump`, stores dump into file provided as first argument or `dump.sql` instead

* `dbbackup.sh` - backups and bzip2s dump, filename contains datetime by format `%Y-%m-%d_%H-%M-%S`

* `diffs/` - by default we are keeping db patch files there

* `dump.sql` - default dump file


Usage examples
--------------

`./dbreset.sh dump.sql`

`./dbpatch.sh diffs/migration-users-roles.sql`

`echo 'select count(*) from users' | ./dbconsole.sh`

(it wouldn't work if you use Docker)

`./dbconsole.sh -e 'select count(*) from users'`

`./dbbackup.sh`


Credits
-------

To all my friends who proved usefulness of this set by daily usage.
