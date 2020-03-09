# Programming in SQL

SQL is a powerful language for manipulating relational data, but it is **not** a powerful programming language.  
At some point in developing complete data base applications, we need to:

* implement user interactions
* control sequences of database operations
* process query results in complex ways

and SQL cannot do any of these.

## Database Programming

Database programming requires a combination of 

* manipulation of data in databases (via SQL)
* conventional programming (via procedural code)

This combination is realised in a number of ways:

* passing SQL commands via a "call-level" interface (the programming language is decoupled from DBMS; most flexible; e.g. Java/JDBC, PHP)
* embedding SQL into augmented programming languages (requires pre-processor for languages; typically DBMS-specific; e.g. SQL/C)
* special-purpose programming languages in DBMS (closely integrated with DBMS; enable extensibility; e.g. PL/SQL, PLpgSQL)

Combining SQL and procedural code solves the "withdrawal" problem  
Using SQL/PSM syntax:

``` sql
create function withdraw(acctNum text, amount integer) returns text
declare bal integer;
begin
    set bal = (select balance from Accounts where acctNo = acctNum);
    if (bad < amount) then
        return 'Insufficent Funds';
    else
        update Accounts
        set balance = balance - amount
        where acctNo = acctNum;
        set bal = (select balance from Accounts where acctNo = acctNum)
        return 'New Balance: '||bal;
    end if
end;
```

### PostgreSQL Stored Procedures

PostgreSQL syntax for defining stored functions:

``` sql
CREATE OR REPLACE FUNCTION funcNum(arg1, arg2, ...) RETURNS retType
AS $$
    String containing function definition
$$ LANGUAGE funcDefLanguage;

-- Note:
-- * argi consists of: name type
-- * $$...$$ are just another tpe of string quote
-- * function defintion languages: SQL, PLpgSQL, Python
```

The PLpgSQL interpreter executes procedural code and manages variables. It calls PostgreSQL engine to evaluate SQL statements.

![postgresql engine](imgs/4-19_postgresql-engine.png)

### Function Return Types

A PostgreSQL function can return a value which is:

* `void` (i.e. no return value)
* an atomic data type (e.g. `integer`, `text`, etc.)
* a tuple (e.g. table record type or tuple type)
* a set of atomic values (like a table column)
* a set of tuples (like a table)

A function returning a set of values is similar to a view.

Examples of different function return types:

``` sql
create function factorial(integer) returns integer...
create function EmployeeOfMonth(date) returns Employee...
create function allSalaries() returns setof float...
create function OlderEmployees() returns setof Employee...
```

Different kinds of functions are invoked in different ways:

``` sql
select factorial();                             -- returns one integer
select EmployeeOfMonth('2008-04-01');           -- returns (x,y,z)
select * from EmployeeOfMonth('2008-04-01');    -- one-row table
select * from allSalaries();                    -- single-column table
select * from OlderEmployees();                 -- subset of Employees
```

### SQL Functions

PostgreSQL allows functions to be defined in SQL:

``` sql
CREATE OR REPLACE funcName(arg1 type, arg2 type, ...) RETURNS retType
AS $$
    SQL statements
$$ LANGUAGE sql
```

Within the function, arguments are accessed as `$1`, `$2` ...  
The return value is the result of the last SQL statement  
`retType` can be any PostgreSQL data type (including tuples and tables)  
For a function to return a table, use: `return setof TupleType`

Examples:
``` sql
-- max price of specified beer
create or replace function maxPrice(text) returns float
as $$
    select max(price) from Sells where beer = $1;
$$ language sql;

-- usage examples
select maxPrice('New');
maxprice
----------
2.8

select bar,price from sells where beer='New' and price=maxPrice('New');
bar         | price
------------+-------
Marble Bar  | 2.8

-- set of Bars from specified suburb
create or replace function hotelsIn(text) returns setof Bars
as $$
    select * from Bars where addr = $1;
$$ language sql;

-- usage examples
select * from hotelsIn('The Rocks');
name            | addr      | license
----------------+-----------+---------
Australia Hotel | The Rocks | 123456
Lord Nelson     | The Rocks | 123888
```

### Functions vs. Views

A parameterless function behaves similar to a view

Let us compare a view and function which do the same thing

``` sql
create or replace view EmpList(name, addr) as
select family||' '||given, street||', '||town, from Employees;

-- which is used as
select * from EmpList;

create type EmpRecord as (name text, addr text);

create or replace function EmpList() returns setof EmpRecord
as $$
    select family||' '||given, street||', '||town, from Employees;
$$ language sql

-- which is used as
select * from EmpList();
```
