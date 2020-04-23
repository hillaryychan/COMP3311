# Database Administration (Security, Privilege, Authorisation)

## Database Security

Database security has to meet the following objectives:

* **Secrecy**: information is not disclosed to unauthorised users; e.g. a student should **not** be able to examine other students' marks
* **Integrity**: only authorised users are allowed to modify data; e.g. a student should not be able to modify anyone's marks
* **Availability**: authorised users should not be denied access; e.g. the LIC should be able to read/change marks for their course

The goal is to prevent unauthorised use/alteration/destruction of mission-critical data

Security mechanisms operate at a number of levels:

* within the database (SQL-level privileges); e.g. specific users can query/modify/update only specified database objects
* accessing the database system (users/passwords); e.g. users are required to authenticate themselves at connection-time
* operating system (access to database client); e.g. users should not obtains access to the DBMS superuser account
* network (most database access nowadays is via network); e.g. results should not be transmitted unencrypted to Web browsers
* human/physical (conventional security mechanisms); e.g. no unauthorised physical access to server hosting the DBMS

## Database Access Control

Access to DBMSs involves two aspects:

* having execute permissions for a DBMS client (e.g. `psql`)
* having username/password registered in the DBMS

Establishing a **_connection_** to the database:

1. user supplied database/username/password to client
2. client passes these to server, which validates them
3. if valid, user is "logged in" to the specific database

Note: on CSE, we don't need to supply username/password to `psql` because `psql` works out which user, by who ran the client process. We're all PostgreSQL superusers on our own servers, and the servers are configured to all super-users direct access

The SQL standard doesn't specify details of user/groups/roles.  
Some typical operations on users:

``` sql
CREATE USER Name IDENTIFIED BY 'Password';
ALTER USER Name IDENTIFIED BY 'NewPassword';
ALTER USER Name WITH Capabilities;
ALTER USER Name SET ConfigParamter = ...;
-- Capabiliies:  super user, create databases, create users etc.
-- Config paramters: resource usage, session settings etc.
```

A user may be associated with a **_group_** (aka role).  
Some typical operations on groups:

``` sql
CREATE GROUP Name;
ALTER GROUP Name ADD USER User1, User2, ...;
ALTER GROUP Name DROP USER User1, USer2, ...;
```

Examples of groups/roles:

* `AcademicStaff` have privileges to read/modify marks
* `OfficeStaff` have privileges to read all marks
* `Student` have privileges to read their own marks only

### Database Access Control in PostgreSQL

In older versions of PostgreSQL:

* `USERS` and `GROUPS` were distinct kinds of objects
* `USERS` were added via `CREATE USER UserName`
* `GROUPS` were added via `CREATE GROUP GroupName`
* `GROUPS` were built via `ALTER GROUP GroupName ADD USER ...`

In recent versions, `USERS` and `GROUPS` are unified by `ROLES`  
The older syntax is retained for backward compatibility.

PostgreSQL has two ways to create users.

``` sql
-- From the unix command line, via the command
createuser Name

-- From SQL, via the statement:
CREATE ROLE UserName Options
-- where Options include:
PASSWORD 'Password'
CREATEDB | NOCREATEDB
CREATEUSER | NOCREATEUSER
IN GROUP GroupName
VALID UNTIL 'TimeStamp'
```

Groups are created as `ROLEs` via

``` sql
CREATE ROLE GroupName
-- or
CREATE ROLE GroupName WITH USER User1, User2, ...
-- and may subseuently modified by
GRANT GroupName TO User1, User2, ...
REVOKE GroupName FROM User1, User2, ...
GRANT Privileges ... TO GroupName
REVOKE Privileges ... FROM GroupName
```

### SQL Access Control

SQL access control deals with:

* privileges on database objects (e.g. tables, views, functions)
* allocating such privileges to rules (i.e. users and groups)

The user who creates an object is automatically assigned:

* ownership of that object
* a privilege to modify (`ALTER`) the object
* a privilege to remove (`DROP`) the object
* along with all other privileges specified below

The owner of an object can assign privileges on that object to other users.  
This is accomplished via the command:

``` sql
GRANT Privileges ON Object
TO (ListOfRoles | PUBLIC)
[WITH GRANT OPTION]

-- Privileges can be ALL (giving everything but ALTER and DROP)
-- WITH GRANT OPTION allows a user who has been granted
-- a privilege to pass to privilege on to other users
```

Privileges can be withdrawn via the command:

``` sql
REVOKE Privileges ON Object
FROM (ListOfRoles | PUBLIC)
CASCADE | RESTRICT

-- This normally withdraws `Privileges` from just specified users/roles.
-- CASCADE also withdraws from users they had granted to
-- e.g. revoking from U1 also revokes U5 and U6
-- RESTRICT fails if users granted privileges to others
-- e.g. revoking form U1 fails, revoking U5 or U2 succeeds
```

Privileges available for users on database objects:

* `SELECT`: user can read all rows and columns from table/view, this includes columns added later via `ALTER TABLE`
* `INSERt` or `INSERT(ColName)`: user can insert rows into table; if `ColName` specified, can only set value of that columns

More privileges available for users on database objects:

* `UPDATE`: user can modify values stored in the table
* `UPDATE(ColName)`: user can update specified column
* `DELETE`: user can delete row from the table
* `REFERENCES(ColName)`: user can use column as foreign key
* `EXECUTE`: user can execute the specified function
* `TRIGGER`: user is allowed to create triggers on table
