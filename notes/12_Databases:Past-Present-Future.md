# Databases: Past, Present, Future

The core goals of "databases" is:

* deal with very large amounts of data (terabytes, petabytes)
* very-high-level languages (deal with big data in uniform ways)
* query optimisation (evaluation too slow ⇒ useless)

There are three phases in DBMS history:

* 1960's: pre-history, first attempts at generalised data access
* 1970's-2000's: relational databases, structure, transactions
* 2000's: big data, less structure, relaxed transactions

## The Past

**1960's:** Database Pre-History:

* simple structured records - atomic-valued records (like relational tuples)
* hierarchical data model
    * all data organised via tree structure
    * access by following paths in hierarchy
    * could only represent 1:n relationships
* network data model
    * relationships between records via links
    * query via traversal of record graphs
    * developed in late 60's, persisted until early 80's

**1970's**: The Rise of Relational DBMSs

* Codd developed the relational model - sets of tuples, relational algebra,...
* IBM developed DBMS based on model (System R)
    * high-level (declarative) query language
    * implementation of efficient relational operations
    * implementation of transaction/recovery
    * System R eventually developed into DB2
* Larry Ellison commercialised the idea (Oracle)

**1980's**: Development of RDBMS's:

* distribution/replication of data
* improving implementation of relational operators

**1990's**: Standardisation and Extension

* SQL standard developed
* SQL extended with e.g. PL/SQL, recursion
* improving implementation of relational operators

**2000's**: New Data

* temporal aspects of data
* stream data (continuous queries)
* high-dimensional data (e.g. imagine feature spaces)

## The Present

RDBMS's have been the dominant database technology for 40 years.

Assumptions underlying relational DBMSs:

* data resides on disk device (latency, block-transfer)
* data located on a single machine (?)
* data fits on (large array of) disks on LAN
* data can be represented via atomic-valued tuples
* queries involve precise matching (e.g. equality etc.)

How things have changed lately:

* growth in use of SSDs for data storages
* need to store **_very_** large amounts of data

Limitations/pitfalls of RDBMS:

* `NULL` is ambiguous: unknown, not applicable, not supplied
* "limited" support for constraints/integrity and rules
* no support for uncertainty (data represents _the_ state-of-the-world)
* data model too simple (e.g. no support for complex objects)
* query model too rigid (e.g. no approximate match)
* continually changing data sources not well-handled
* data must be "moulded" to fit a single rigid schema
* database systems must be manually "tuned"
* does not scale well to some data sets (e.g. Google, Telco's)

To overcome these limitations we can:

* **extend** the relational model
    * add new data types and query ops for new applications
    * deal with uncertainty/inaccuracy/approximation in data
* **replace** the relational model
    * object-oriented DBMS - OO programming with persistent objects
    * XML DBMS - all data stored as XML documents, new query model
    * application-effective data model (e.g `(key, value)` pairs)

Performance: DBMSs that "tune" themselves...

## The Future

Every so often, DBMS researchers meet to consider the future of the field

* [Laguna Beach, 1989](http://doi.acm.org/10.1145/382272.1367994)
* [Asilomar, 1998](http://doi.acm.org/10.1145/306101.306137)
* [Claremont, 2008](http://doi.acm.org/10.1145/1462571.1462573)
* [Beckman, 2016](http://doi.acm.org/10.1145/2845915)

Regular attendees: Rakesh Agrawal (IBM), Phil Bernstein (MS), Mike Carey (BEA), Stefano Ceri (Pisa), David deWitt (MS), Michael Franklin (UCB), Hector Garcia-Molina (Stanford)
Jim Gray (MS), Laura Haas (IBM), Alon Halevy (Google) Joe Hellerstein (UCB), Mike Lesk (Bell), David Maier (PSU), Raghu Ramakrishnan (Yahoo), Avi Silberschatz (Bell), Rick
Snodgrass (Arizona), Mike Stonebraker (UCB/MIT), Jeff Ullman (Stanford), Jennifer Widom (Stanford), ...

### Big Data

Some modern applications have massive data sets (e.g. Google), which are far too large to store on a single machine/RDBMS and query demands are far too high even if you could store them in a DBMS.

Approaches to dealing with such data:

* distribute data over large collection of nodes (redundancy)
* provide computational mechanisms for distributing computation

Often this data does not need full relational selection

* represent data via `(key,value')` pairs
* unique _key_ values can be used for addressing data
* _values_ can be large objects (e.g. web pages, images etc.)

Popular computational approaches to Big Data: `map/reduce`

* suitable for widely-distributed, very-large data
* allows parallel computation on such data to be easily specified
* distribute (map) parts of computation across network
* compute in parallel (possible with further `map`-ing)
* merge (`reduce`) multiple results for delivery to requester

Some Big Data advocates see no future for SQL/relational DBMS, but this depends on the application (e.g. hard integrity vs. eventual consistency)

### Information Retrieval

DBMSs generally do precise matching (although we already have `LIKE` and regex).

Information retrieval systems do approximate matching; e.g. documents containing specific words. This also introduces the notion of "quality" of matching (e.g. tuple T1 is a _better_ match than tuple T2). Quality also implies _ranking_ of results.

There has been much activity in incorporating information retrieval into the DBMS context.  
The goal being, support database exploration better

### Multimedia Data

There is data, which does not fit the "tabular model": images, video, music, text ... (and combinations of these)

Research problems:

* how to specify queries on such data? (_image1=image2_)
* how to display results? (synchronise components)

Solutions to the first problem typically:

* extend notions of "matching"/indexes for querying
* require sophisticated methods for capturing data features

Sample query: find other songs _like_ this one?

### Uncertainty

Multimedia/Information retrieval introduces approximate matching.

In some contexts, we have approximate/uncertain data; e.g. witness statements in a crime-fighting database "I think the getaway car was red ... or maybe orange ..." "I am 75% sure that John carried out the crime"

Work by Jennifer Widom at Stanford on the Trio system:

* extends the relational model (ULDB)
* extends the query language (TriQL)

### Stream Management Systems

Stream management systems make one addition to the relational model; streams - an infinite sequence of tuples, arriving one-at-a-time

Applications: news feed, telecoms, monitoring web usage, ...

RDBMS: run a variety of queries on (relatively) fixed data  
StreamDBs: run fixed queries on changing data (stream)

Approaches:

* **_window_** = relation formed from a stream via a rule
* **_stream data type_** = build a new stream-specific operation

### Semi-structured Data

Uses _graphs_ rather than tables as basic data structure tool.

Applications: complex data representation, via "flexible" objects, e.g. XML

The graph nature of data changes the query model considerably (e.g. Xquery language, high-level like SQL, but different operators, etc.)  
Implementing graphs in RDBMSs is often inefficient.

Research problem: query processing for XML data.

### Dispersed Databases

Characteristics of dispersed databases:

* very large number of small processing nodes
* data is distributed/shared among nodes

Applications: environmental monitoring devices, "intelligent dust"

Research issues:

* query/search strategies (how to organise query processing)
* distribution of data (trade-off between centralised and diffused)

Less extreme versions of this already exists:

* grid and cloud computing
* database management for mobile devices
