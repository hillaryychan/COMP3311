create table Movies (
	id          integer,
	title       varchar(256),
	year        integer check (year >= 1900),
	primary key (id)
);

create table BelongsTo (
	movie       integer references Movies(id),
	genre       varchar(32),
	primary key (movie,genre)
);

create table Actors (
	id          integer,
	familyName  varchar(64),
	givenNames  varchar(64),
	gender      char(1),
	primary key (id)
);

create table AppearsIn (
	actor       integer references Actors(id),
	movie       integer references Movies(id),
	role        varchar(64),
	primary key (movie,actor,role)
);

create table Directors (
	id          integer,
	familyName  varchar(64),
	givenNames  varchar(64),
	primary key (id)
);

create table Directs (
	director    integer references Directors(id),
	movie       integer references Movies(id),
	primary key (director,movie)
);
