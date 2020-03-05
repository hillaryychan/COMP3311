-- COMP3311 Prac 03 Exercise
-- Populate the database for the simple company schema
-- This should produce errors once all constraints are added
begin;
set constraints all deferred;

insert into Employees values ('777-654-321','Yusif','Budianto',40.0,'003');
insert into Employees values ('123-987-654','Maria','Orlowska',40.0,'003');
insert into Employees values ('323-626-929','Tom','Robbins',35.0,'001');
insert into Employees values ('993-893-864','Susan','Ryan',60.0,'001');
insert into Employees values ('419-813-573','Max','Schmidt',40.0,'003');
insert into Employees values ('222-333-444','Pradeep','Sharma',30.0,'002');
insert into Employees values ('123-234-456','John','Smith',40.0,'001');
insert into Employees values ('632-647-973','Steven','Smooth',45.0,'002');
insert into Employees values ('747-400-123','Adam','Spencer',50.0,'002');
insert into Employees values ('326-888-711','Walter','Wong',50.0,'003');

insert into Departments values ('001','Administration','123-234-456');
insert into Departments values ('002','Sales','222-333-444');
insert into Departments values ('003','Research','326-888-711');

insert into DeptMissions values ('001','innovation');
insert into DeptMissions values ('001','reliability');
insert into DeptMissions values ('001','profit');
insert into DeptMissions values ('002','customer-focus');
insert into DeptMissions values ('002','growth');
insert into DeptMissions values ('003','innovation');
insert into DeptMissions values ('003','technology');

commit;
