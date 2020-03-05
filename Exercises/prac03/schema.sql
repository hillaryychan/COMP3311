-- COMP3311 Prac 03 Exercise
-- Schema for simple company database

create table Employees (
	tfn         char(11) check (tfn ~ '^[0-9]{3}-[0-9]{3}-[0-9]{3}$'),
	givenName   varchar(30) not null,
	familyName  varchar(30),
	hoursPweek  float check (hoursPweek >= 0 and hoursPweek <= 168),
	primary key (tfn)
);

create table Departments (
	id          char(3) check (id ~ '^[0-9]{3}$'),
	name        varchar(100) unique,
	manager     char(11) unique,
	primary key (id),
	foreign key (manager) references Employees(tfn)
);

create table DeptMissions (
	department  char(3),
	keyword     varchar(20),
	primary key (department, keyword),
	foreign key (department) references Departments(id)
);

create table WorksFor (
	employee    char(11),
	department  char(3),
	percentage  float check (percentage > 0 and percentage <= 100),
	primary key (employee, department),
	foreign key (employee) references Employees(tfn),
	foreign key (department) references Departments(id)
);

