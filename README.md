_db
===

Simple set of MySQL cli tools


Initialization
--------------

Copy `_db` into some place (usually inside your project directory).

Create config for the tools by copying provided default config `db.conf.example` into `db.conf`

    cp db.conf.example db.conf

Update config by substituting your credentials.


Tools description
-----------------

* `dbreset.sh` - drops database, creates new one, applies dump file passed as first argument; if dump file is missed, `dump.sql` used instead

* `dbconsole.sh` - opens mysql console

* `dbpatch.sh` - applies patch specified as first argument

* `dbdump.sh` - calls `mysqldump`, stores dump into file provided as first argument or `dump.sql` instead

* `dbbackup.sh` - backups and bzip2s dump, filename contains datetime by format `%Y-%m-%d_%H-%M-%S`

* `diffs/` - by default we are keeping db patch files here

* `dump.sql` - default dump file


Usage examples
--------------

`./dbpatch.sh diffs/users.sql`

`echo 'select * from users' | ./dbconsole.sh`


Credits
-------

To all my friends who proved usefulness of this set by daily usage.
