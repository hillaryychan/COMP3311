# sqlite3

usage: `sqlite3 <database file>`

`.help` for help
`.quit` to exit sqlite

note all meta-commands begin with `.`

SQL keywords are case sensitive.
Identifiers in SQL are case insensitive

select <field>[,<fields] from <table>;
`||` is SQL's string concatenation operator.e.g.
`select givenNames||' '||familyName from Directors;`

can order queries:
`select givenNames||' '||familyName from Directors order by familyName;`

count tuples:
`select count(*) from Directors;`
