-- COMP3311 Prac 03 Exercise Q10
-- Schema for simple company database

create table Employees (
	tfn         char(11) check (tfn ~ '^[0-9]{3}-[0-9]{3}-[0-9]{3}$'),
	givenName   varchar(30) not null,
	familyName  varchar(30),
	hoursPweek  float check (hoursPweek >= 0 and hoursPweek <= 168),
    department  char(3) check (department ~ '^[0-9]{3}$'),
	primary key (tfn)
);

create table Departments (
	id          char(3) check (id ~ '^[0-9]{3}$'),
	name        varchar(100) unique,
	manager     char(11) unique,
	primary key (id),
	foreign key (manager) references Employees(tfn) deferrable
);

alter table Employees add foreign key (department) references Departments(id) deferrable;

create table DeptMissions (
	department  char(3),
	keyword     varchar(20),
	primary key (department, keyword),
	foreign key (department) references Departments(id)
);
