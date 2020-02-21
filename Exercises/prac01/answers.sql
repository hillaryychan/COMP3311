-- Exercise 1: SQLite: a simple RDBMS

-- Q1: How many movies are in the database?

select count(*) from Movies;
-- 65

-- Q2: What are the titles of all movies in the database?

select title from Movies;

-- Q3: What is the earliest year that film was made (in this database)? (Hint: there is a min() summary function)

select min(year) from Movies;
-- 1975 Jaws

-- Q4: How many actors are there (in this database)?

select count(*) from Actors;
-- 2999

-- Q5: Are there any actors whose family name is "Zeta-Jones"? (case-sensitive)

select givenNames|' '||familyName from Actors where familyname="Zeta-Jones";

-- Q6: What genres are there?

select distinct genre from belongsIn;
-- Comedy
-- War
-- Action
-- Adventure
-- Sci-Fi
-- Thriller
-- Drama
-- Horror
-- History
-- Mystery
-- Crime
-- Biography
-- Musical
-- Fantasy
-- Family
-- Documentary
-- Short
-- Romance

-- Q7: What movies did Spielberg direct? (title+year)

select Movies.title||' '||Movies.year
from Movies, Directs, Directors 
where Directors.familyName="Spielberg" and Directs.movie = Movies.id and Directs.director = Directors.id;

-- Q8: Which actor has acted in all movies (in this database)?




-- Q9: Are there any directors in the database who don't direct any movies?



