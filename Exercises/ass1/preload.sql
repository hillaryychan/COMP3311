--
-- PostgreSQL 20T1 ass1 database
--

CREATE TABLE client (
    pid integer,
    cid integer NOT NULL
);

CREATE TABLE coverage (
    coid integer NOT NULL,
    cname character varying(20),
    uplimit real,
    comments character varying(80),
    pno integer
);

CREATE TABLE insured_by (
    cid integer NOT NULL,
    pno integer NOT NULL
);

CREATE TABLE insured_item (
    id integer NOT NULL,
    brand character varying(10),
    model character varying(20),
    year integer,
    reg character varying(10) NOT NULL,
    CONSTRAINT insured_item_year_check CHECK (((year > 1900) AND (year < 2099)))
);

CREATE TABLE person (
    pid integer NOT NULL,
    firstname character varying(20),
    lastname character varying(20),
    bdate date,
    street character varying(30),
    suburb character varying(20),
    state character varying(3),
    postcode character(4)
);

CREATE TABLE policy (
    pno integer NOT NULL,
    pname character varying(1),
    status character varying(2),
    effectivedate date,
    expirydate date,
    agreedvalue real,
    comments character varying(80),
    sid integer,
    id integer
);

CREATE TABLE rated_by (
    sid integer NOT NULL,
    rid integer NOT NULL,
    rdate date,
    comments character varying(80)
);

CREATE TABLE rating_record (
    rid integer NOT NULL,
    rate real,
    status character varying(2),
    coid integer
);

CREATE TABLE staff (
    pid integer,
    sid integer NOT NULL
);

CREATE TABLE underwriting_record (
    urid integer NOT NULL,
    status character varying(2),
    pno integer
);

CREATE TABLE underwritten_by (
    sid integer NOT NULL,
    urid integer NOT NULL,
    wdate date,
    comments character varying(80)
);


--
-- Inserting sample data below.
--

INSERT INTO client VALUES (0, 0);
INSERT INTO client VALUES (2, 1);
INSERT INTO client VALUES (3, 2);
INSERT INTO client VALUES (8, 3);
INSERT INTO client VALUES (9, 4);

INSERT INTO coverage VALUES (0, 'legal service', 2850, 'other benefit: refund of emergency cost', 0);
INSERT INTO coverage VALUES (1, 'property damange', 20850, 'NONE', 1);
INSERT INTO coverage VALUES (2, 'legal service', 2850, 'other benefit: refund of emergency cost', 2);
INSERT INTO coverage VALUES (3, 'property damange', 2850, 'NONE', 3);
INSERT INTO coverage VALUES (4, 'property damange', 2850, 'NONE', 4);
INSERT INTO coverage VALUES (5, 'third party', 20000000, 'NONE', 5);
INSERT INTO coverage VALUES (6, 'property damage', 20850, 'NONE', 5);
INSERT INTO coverage VALUES (7, 'third party', 20000000, 'NONE', 6);
INSERT INTO coverage VALUES (8, 'third party', 20000000, 'NONE', 7);
INSERT INTO coverage VALUES (9, 'third party', 20000000, 'NONE', 8);
INSERT INTO coverage VALUES (10, 'third party', 20000000, 'NONE', 9);
INSERT INTO coverage VALUES (11, 'third party', 20000000, 'NONE', 10);
INSERT INTO coverage VALUES (12, 'third party', 20000000, 'NONE', 11);

INSERT INTO insured_by VALUES (0, 0);
INSERT INTO insured_by VALUES (0, 1);
INSERT INTO insured_by VALUES (0, 2);
INSERT INTO insured_by VALUES (0, 3);
INSERT INTO insured_by VALUES (1, 3);
INSERT INTO insured_by VALUES (1, 4);
INSERT INTO insured_by VALUES (2, 4);
INSERT INTO insured_by VALUES (2, 5);
INSERT INTO insured_by VALUES (2, 6);
INSERT INTO insured_by VALUES (2, 7);
INSERT INTO insured_by VALUES (4, 8);
INSERT INTO insured_by VALUES (3, 9);
INSERT INTO insured_by VALUES (3, 10);
INSERT INTO insured_by VALUES (3, 11);

INSERT INTO insured_item VALUES (0, 'Nissan', 'Micra K11 LX', 1995, 'NTQ-254');
INSERT INTO insured_item VALUES (1, 'Toyota', 'Camry Altise', 2004, 'ATB-252');
INSERT INTO insured_item VALUES (2, 'Toyota', 'Camry Altise', 2004, 'CDZ-848');
INSERT INTO insured_item VALUES (3, 'Nissan', 'Micra K11 LX', 1995, 'VCN-214');
INSERT INTO insured_item VALUES (4, 'Honda', 'Civic', 2006, 'TCL-222');
INSERT INTO insured_item VALUES (5, 'Toyota', 'Ateva', 2002, 'UYT-962');
INSERT INTO insured_item VALUES (6, 'Nissan', 'Micra K11 LX', 2005, 'XMD-260');
INSERT INTO insured_item VALUES (7, 'Nissan', 'Micra K11 LX', 2007, 'LKH-886');

INSERT INTO person VALUES (0, 'Jack', 'White', '1951-09-15', '215 Main St.', 'Rosslea', 'QLD', '4007');
INSERT INTO person VALUES (1, 'David', 'Lee', '1976-10-05', '21 George St.', 'Tissa', 'QLD', '4007');
INSERT INTO person VALUES (2, 'Mary', 'Jones', '1990-01-11', '87 Alex Av.', 'Parramatta', 'NSW', '2165');
INSERT INTO person VALUES (3, 'Vicky', 'Donald', '1982-10-11', '21 Pitt St.', 'Surry Hill', 'NSW', '2000');
INSERT INTO person VALUES (4, 'Vicent', 'Thomas', '1973-01-17', '458 Clevelend St.', 'Kingsford', 'NSW', '2052');
INSERT INTO person VALUES (5, 'Teresa', 'Story', '1985-12-23', '458 Knox St.', 'Epping', 'NSW', '2012');
INSERT INTO person VALUES (6, 'Alice', 'Wang', '1978-07-31', '92 Leon St.', 'Wooloomooloo', 'NSW', '2002');
INSERT INTO person VALUES (7, 'David', 'Bond', '1965-08-30', '1 Johnson St.', 'Green Square', 'NSW', '2083');
INSERT INTO person VALUES (8, 'Frederick', 'Brown', '1975-03-28', '4 Good St.', 'Wooloomooloo', 'NSW', '2091');
INSERT INTO person VALUES (9, 'Lucy', 'Smiths', '1968-04-02', '5 Hamony St.', 'Alexendria', 'NSW', '2008');

INSERT INTO policy VALUES (0, 'C', 'E', '2019-11-01', '2020-08-13', 16500, 'The driver had an accident in the last 5 years, Use for business', 0, 0);
INSERT INTO policy VALUES (1, 'C', 'E', '2019-12-16', '2020-09-11', 36500, 'The driver had an accident in the last 5 years, Use for business', 0, 1);
INSERT INTO policy VALUES (2, 'C', 'E', '2019-12-23', '2020-09-23', 46500, 'The driver had an accident in the last 5 years, Use for business', 0, 2);
INSERT INTO policy VALUES (3, 'C', 'D', '2019-11-17', '2020-08-09', 26500, 'The driver had an accident in the last 5 years, Use for business', 0, 3);
INSERT INTO policy VALUES (4, 'G', 'E', '2019-11-16', '2021-08-12', 56500, 'Young driver', 0, 4);
INSERT INTO policy VALUES (5, 'G', 'E', '2019-12-16', '2021-10-12', 16500, 'NONE', 2, 4);
INSERT INTO policy VALUES (6, 'G', 'E', '2019-12-16', '2021-10-12', 32500, 'NONE', 0, 5);
INSERT INTO policy VALUES (7, 'G', 'E', '2018-12-16', '2019-10-12', 32800, 'NONE', 0, 7);
INSERT INTO policy VALUES (8, 'G', 'E', '2018-11-15', '2019-10-12', 27200, 'NONE', 3, 7);
INSERT INTO policy VALUES (9, 'G', 'E', '2018-12-16', '2019-10-12', 31200, 'NONE', 4, 7);
INSERT INTO policy VALUES (10, 'G', 'E', '2019-12-16', '2021-10-12', 33500, 'NONE', 5, 6);
INSERT INTO policy VALUES (11, 'G', 'E', '2019-12-16', '2021-10-12', 16500, 'NONE', 6, 6);

INSERT INTO rated_by VALUES (0, 0, '2020-02-01', 'need more information');
INSERT INTO rated_by VALUES (0, 1, '2020-02-05', 'need more information');
INSERT INTO rated_by VALUES (0, 2, '2020-02-16', 'need more information');
INSERT INTO rated_by VALUES (0, 3, '2020-02-12', 'approved');
INSERT INTO rated_by VALUES (0, 4, '2020-01-11', 'appropriate');
INSERT INTO rated_by VALUES (0, 5, '2020-01-11', 'need more information');
INSERT INTO rated_by VALUES (0, 6, '2020-01-12', 'approved');
INSERT INTO rated_by VALUES (0, 7, '2020-01-12', 'approved');
INSERT INTO rated_by VALUES (0, 8, '2020-01-12', 'approved');
INSERT INTO rated_by VALUES (0, 9, '2020-01-12', 'approved');
INSERT INTO rated_by VALUES (0, 10, '2020-01-12', 'approved');
INSERT INTO rated_by VALUES (0, 11, '2020-01-12', 'approved');
INSERT INTO rated_by VALUES (0, 12, '2020-01-12', 'approved');

INSERT INTO rating_record VALUES (0, 100, 'A', 0);
INSERT INTO rating_record VALUES (1, 300, 'D', 1);
INSERT INTO rating_record VALUES (2, 200, 'D', 2);
INSERT INTO rating_record VALUES (3, 500, 'A', 3);
INSERT INTO rating_record VALUES (4, 1500, 'D', 4);
INSERT INTO rating_record VALUES (5, 300, 'A', 5);
INSERT INTO rating_record VALUES (6, 300, 'A', 6);
INSERT INTO rating_record VALUES (7, 600, 'A', 7);
INSERT INTO rating_record VALUES (8, 400, 'A', 8);
INSERT INTO rating_record VALUES (9, 100, 'A', 9);
INSERT INTO rating_record VALUES (10, 250, 'A', 10);
INSERT INTO rating_record VALUES (11, 230, 'A', 11);
INSERT INTO rating_record VALUES (12, 120, 'A', 12);

INSERT INTO staff VALUES (0, 0);
INSERT INTO staff VALUES (1, 1);
INSERT INTO staff VALUES (4, 2);
INSERT INTO staff VALUES (5, 3);
INSERT INTO staff VALUES (6, 4);
INSERT INTO staff VALUES (7, 5);
INSERT INTO staff VALUES (8, 6);

INSERT INTO underwriting_record VALUES (0, 'R', 0);
INSERT INTO underwriting_record VALUES (1, 'R', 5);
INSERT INTO underwriting_record VALUES (2, 'R', 6);
INSERT INTO underwriting_record VALUES (3, 'R', 7);

INSERT INTO underwritten_by VALUES (0, 0, '2020-03-02', 'rate is appropriate');
INSERT INTO underwritten_by VALUES (0, 1, '2020-03-03', 'rate is appropriate');
INSERT INTO underwritten_by VALUES (0, 2, '2020-03-03', 'rate is appropriate');
INSERT INTO underwritten_by VALUES (0, 3, '2020-03-03', 'rate is appropriate');


--
-- Add the table contraints to the tables.
--

ALTER TABLE ONLY client
    ADD CONSTRAINT client_pkey PRIMARY KEY (cid);

ALTER TABLE ONLY coverage
    ADD CONSTRAINT coverage_pkey PRIMARY KEY (coid);

ALTER TABLE ONLY insured_by
    ADD CONSTRAINT insured_by_pkey PRIMARY KEY (cid, pno);

ALTER TABLE ONLY insured_item
    ADD CONSTRAINT insured_item_pkey PRIMARY KEY (id);

ALTER TABLE ONLY insured_item
    ADD CONSTRAINT insured_item_reg_key UNIQUE (reg);

ALTER TABLE ONLY person
    ADD CONSTRAINT person_pkey PRIMARY KEY (pid);

ALTER TABLE ONLY policy
    ADD CONSTRAINT policy_pkey PRIMARY KEY (pno);

ALTER TABLE ONLY rated_by
    ADD CONSTRAINT rated_by_pkey PRIMARY KEY (sid, rid);

ALTER TABLE ONLY rating_record
    ADD CONSTRAINT rating_record_pkey PRIMARY KEY (rid);

ALTER TABLE ONLY staff
    ADD CONSTRAINT staff_pkey PRIMARY KEY (sid);

ALTER TABLE ONLY underwriting_record
    ADD CONSTRAINT underwriting_record_pkey PRIMARY KEY (urid);

ALTER TABLE ONLY underwritten_by
    ADD CONSTRAINT underwritten_by_pkey PRIMARY KEY (urid, sid);

ALTER TABLE ONLY client
    ADD CONSTRAINT client_pid_fkey FOREIGN KEY (pid) REFERENCES person(pid);

ALTER TABLE ONLY coverage
    ADD CONSTRAINT coverage_pno_fkey FOREIGN KEY (pno) REFERENCES policy(pno);

ALTER TABLE ONLY insured_by
    ADD CONSTRAINT insured_by_cid_fkey FOREIGN KEY (cid) REFERENCES client(cid);

ALTER TABLE ONLY insured_by
    ADD CONSTRAINT insured_by_pno_fkey FOREIGN KEY (pno) REFERENCES policy(pno);

ALTER TABLE ONLY policy
    ADD CONSTRAINT policy_id_fkey FOREIGN KEY (id) REFERENCES insured_item(id);

ALTER TABLE ONLY policy
    ADD CONSTRAINT policy_sid_fkey FOREIGN KEY (sid) REFERENCES staff(sid);

ALTER TABLE ONLY rated_by
    ADD CONSTRAINT rated_by_rid_fkey FOREIGN KEY (rid) REFERENCES rating_record(rid);

ALTER TABLE ONLY rated_by
    ADD CONSTRAINT rated_by_sid_fkey FOREIGN KEY (sid) REFERENCES staff(sid);

ALTER TABLE ONLY rating_record
    ADD CONSTRAINT rating_record_coid_fkey FOREIGN KEY (coid) REFERENCES coverage(coid);

ALTER TABLE ONLY staff
    ADD CONSTRAINT staff_pid_fkey FOREIGN KEY (pid) REFERENCES person(pid);

ALTER TABLE ONLY underwriting_record
    ADD CONSTRAINT underwriting_record_pno_fkey FOREIGN KEY (pno) REFERENCES policy(pno);

ALTER TABLE ONLY underwritten_by
    ADD CONSTRAINT underwritten_by_sid_fkey FOREIGN KEY (sid) REFERENCES staff(sid);

ALTER TABLE ONLY underwritten_by
    ADD CONSTRAINT underwritten_by_urid_fkey FOREIGN KEY (urid) REFERENCES underwriting_record(urid);
