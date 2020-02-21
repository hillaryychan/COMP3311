-- COMP3311 18s1 Prac Exercise 01 - Sample Solutions

-- Schema:
-- Actors(id, familyName, givenNames, gender)
-- AppearsIn(actor, movie, role)
-- BelongsTo(movie, genre)
-- Directors(id, familyName, givenNames)
-- Directs(director, movie)
-- Movies(id, title, year)

-- Q1: How many movies are in the database?

select count(*) from Movies;

-- Q2: What are the titles of all movies in the database?

select title from Movies;

-- Q3: What is the earliest year that film was made (in this database)?

select min(year) from Movies;

-- Q4: How many actors are there (in this database)?

select count(*) from Actors;

-- Q5: Are there any actors whose family name is Zeta-Jones? (case-sensitive)

select givennames||' '||familyname from actors where familyname='Zeta-Jones';

-- Q6: What genres are there?

select distinct(genre) from belongsto;

-- Q7: What movies did Spielberg direct? (title+year)

select m.title, m.year
from   Movies m
		join Directs s on (s.movie = m.id)
		join Directors d on (s.director = d.id)
where d.familyname = 'Spielberg';
-- or
select m.title, m.year
from   Movies m, Directs s, Directors d
where d.familyname = 'Spielberg' and s.movie = m.id
		and s.director = d.id;

-- Q8: Which actor has acted in all movies (in this database)?

-- strategy:
-- for each actor A {
--	  M1 = all movies that A has acted in
--    M2 = all movies
--    check if M1 == M2 (using isEmpty(M2-M1))
--
-- Unfortunately, there are no instances in the database

select a.givennames||' '||a.familyname
from   Actors a
where  not exists (
			select id from movies
			except
			select movie as id from AppearsIn where actor = a.id
		);

-- Q9: Are there any directors in the database who don't direct any movies?

-- strategy:
-- use outer join to get info on all directors and movies directed
--   (directors who directed nothing have a single entry with NULL movie)
-- group by director and count size of each group (NULLs become count 0)

create view nDirected as
select d.id as director, count(s.movie) as ntimes
from   Directors d
		left outer join Directs s on (d.id = s.director)
group  by d.id;

select d.givennames||' '||d.familyname as name
from   nDirected nd join Directors d on (nd.director = d.id)
where  ntimes = 0;


-- Extras

-- Which genres does "Wild at Heart" belong to?

select b.genre
from   Movies m, BelongsTo b
where  m.title='Wild at Heart' and b.movie=m.id;

-- Which movies belong to more than 3 genres?

select m.title,count(b.genre)
from   Movies m join BelongsTo b on (m.id=b.movie)
group  by m.title
having count(b.genre) > 3

-- Which actor appears in the most movies?

create view nAppearances as
select a.id, count(i.movie) as ntimes
from   Actors a join AppearsIn i on (a.id = i.actor)
group  by a.id;

select a.givenNames||' '||a.familyname as name, na.ntimes
from   nAppearances na join Actors a on (na.id=a.id)
where  na.ntimes = (select max(ntimes) from nAppearances);
