-- COMP3311 20T1 Assignment 1

-- Q1. List all persons who are both clients and staff members. Order the result by pid in ascending order.

create or replace view Q1(pid, firstname, lastname) as
select p.pid, p.firstname, p.lastname
from person p, client c, staff s
where p.pid=c.pid and p.pid=s.pid
order by p.pid;

-- Q2.For each car brand, list the car insured by the most expensive policy (the premium, i.e., the sum of its coverages' rates). Order the result by brand, and then by car id, pno if there are ties, all in ascending order.

create or replace view item_rate as
select i.id, i.brand, p.pno, c.coid, r.rate
from insured_item i, policy p, coverage c, rating_record r
where i.id=p.id and p.pno=c.pno and r.coid=c.coid;

create or replace view max_rate as
select brand, max(rate)
from item_rate
group by brand;

create or replace view Q2(brand, car_id, pno, premium) as
select i.brand, i.id, i.pno, i.rate
from item_rate i, max_rate r
where r.max=i.rate and r.brand=i.brand
order by i.brand, i.id, i.pno;

-- Q3. List all the staff members who did not sell any policies in the last 365 calendar days (from today). Note that policy.sid records the staff who sold this policy, underwritten_by.wdate records the date a policy is sold (we ignore the status here). Order the result by pid in ascending order.

create or replace view not_selling_staff as
select sid from staff
except
select p.sid
from policy p, underwriting_record ur, underwritten_by ub
where ur.urid=ub.urid and ur.pno=p.pno and ub.wdate >= now() - interval '365 day';

create or replace view Q3(pid, firstname, lastname) as
select p.pid, p.firstname, p.lastname
from person p, staff s, not_selling_staff nss
where nss.sid=s.sid and s.pid=p.pid
order by p.pid;

-- Q4.For each suburb in NSW, compute the number of policies that have been sold to the policy holders living in the suburb (regardless of the policy status). Order the result by Number of Policies (npolicies), then by suburb, in ascending order. Exclude suburbs with no sold policies. Furthermore, suburb names are output in all uppercase.

create or replace view Q4(suburb, npolicies) as
select upper(p.suburb), count(i.pno) as npolicies
from person p, client c, insured_by i
where c.pid=p.pid and i.cid=c.cid and p.state='NSW'
group by p.suburb
order by npolicies, p.suburb;

-- Q5. Find the policies which are rated, underwritten, and sold by the same staff member. Order the result by pno in ascending order.

create or replace view same_staff_policy as
select p.pno, p.pname, p.sid
from policy p, rated_by rb, rating_record rr, coverage c
where p.sid=rb.sid and c.pno=p.pno and rr.coid=c.coid and rr.rid=rb.rid
intersect
select p.pno, p.pname, p.sid
from policy p, underwritten_by ub, underwriting_record ur
where p.sid=ub.sid and p.pno=ur.pno and ur.urid=ub.urid;

create or replace view Q5(pno, pname, pid, firstname, lastname) as
select ssp.pno, ssp.pname, p.pid, p.firstname, p.lastname
from same_staff_policy ssp, person p, staff s
where s.pid=p.pid and s.sid=ssp.sid
order by ssp.pno;

-- Q6. List the staff members (their firstname, a space and then the lastname as one column called name) who only sell policies to cover one brand of cars. Order the result by pid in ascending order.

create or replace view staff_brands as
select distinct pe.pid, pe.firstname||' '||pe.lastname as name, i.brand
from insured_item i, policy po, staff s, person pe
where i.id=po.id and po.sid=s.sid and pe.pid=s.pid ;

create or replace view Q6(pid, name, brand) as
select *
from staff_brands
where pid in (select pid from staff_brands group by pid having count(brand)=1)
order by pid;

-- Q7. List clients (their firstname, a space and then the lastname as one column called name) who hold policies to cover all brands of cars recorded in the database. Order the result by pid in ascending order.

create or replace view client_brands as
select distinct pe.pid, pe.firstname||' '||pe.lastname as name, ii.brand
from client c, person pe, policy po, insured_item ii, insured_by ib
where pe.pid=c.pid and po.pno=ib.pno and c.cid=ib.cid and po.id=ii.id;

create or replace view Q7(pid, name) as
select p.pid, p.firstname||' '||p.lastname as name
from person p
where p.pid in (
    select pid
    from client_brands
    group by pid having
    count(brand)=(
        select count(distinct brand) from insured_item)
);

-- Q8. For each policy X, compute the number of other policies (excluding X) whose coverage is contained by the coverage of X. For example, if a policy X has 3 coverages (identified by cname), say {C1, C2, C3}, and another policy Y has 2 coverages, {C1, C3}, we say Y's coverage is contained by X's. In case if X's and Y's coverages are identical, their coverages are contained by each other. Order the result by pno in ascending order.

--create or replace view Q8(pno, npolicies) as ...

-- Q9. Create a stored function that increases/decreases the rate by Adj% for all active (as of today) and enforced (with status E) policies. Other policies shall not be affected. Adj is an integer between -99 and 99. For example, if the original rate is 200 and Adj is -20, the new rate will be 160. If the original rate is 300 and Adj is 10, the new rate will be 330. The function returns the number of policies that have been adjusted.

--create or replace function ratechange(Adj integer) returns integer ...

-- Q10. The insurance company is to going to run a promotion campaign. If you buy a new policy (whether solely or jointly) and it is finally approved (i.e., the status becomes E), all other active and enforced policies that you are involved (including solely and jointly) will have their expiry dates extended by 30 calendar days. However, if any staff of the company is covered by the new policy, this promotion will not apply. Create a trigger (or triggers) to keep track when a policy status is changed to E and implement this promotion campaign accordingly.
