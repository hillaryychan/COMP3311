# COMP3311 - Database Systems

<!-- @import "[TOC]" {cmd="toc" depthFrom=2 depthTo=3 orderedList=false} -->

<!-- code_chunk_output -->

- [Overview](#overview)
  - [Why Databases?](#why-databases)
  - [What is Data? What is a Database?](#what-is-data-what-is-a-database)
  - [Overview of the Database Field](#overview-of-the-database-field)
  - [Database System Architecture](#database-system-architecture)
- [Data Modelling and Database Design](#data-modelling-and-database-design)
  - [Data Modelling](#data-modelling)
  - [ER Modelling](#er-modelling)
  - [Relational Modelling](#relational-modelling)
- [Database Application Development](#database-application-development)

<!-- /code_chunk_output -->

## Overview

### Why Databases?

Every significant modern computer application has **large data**

This needs to be:

- **stored** typically on a disk device
- **manipulated** efficiently and usefully
- **shared** by many users concurrently
- **transmitted** all around the Internet

The first three points are handled by databases while the last one is handled by networks.

The field of databases deals with:

- _data_ representing application scenarios
- _relationships_ amongst data
- _constraints_ on data and relationships
- _redundancy_ so that each data item has one source
- _data manipulation_ which is declarative or procedural
- _transactions_ covering multiple actions which are either completed or not
- _concurrency_ covering multiple users sharing data
- _scale_ for massive amounts of data

### What is Data? What is a Database?

According to the Elmasri/Navathe textbook,

- **data** is a known fact, with implicit meaning; e.g. a student's name, a product id
- a **database** is a collection of related data which satisfies constraints; e.g. a student is _enrolled_ in a course, a product _is sold_ at a store
- a **DBMS** is a database management system which is software to manage data, control access and enforce constraints; e.g. PostgreSQL, SQLite, Oracle, SQL Server, MySQL

### Overview of the Database Field

![overview of the database field](imgs/1-25_overview-of-database-field.png)

Database application development is variation on standard software engineering process:

1. analyse application requirements
2. develop a data model to meet these requirements
3. define operations (transactions) on this model
4. implement the data model as a relational schema
5. implement transactions via SQL and procedurals languages
6. construct an interface to these transactions

At some point, populate the database (maybe via the interface)

### Database System Architecture

The typical environment for a typical DBMS is:

![typical modern DBMS](imgs/1-27_database-system-architecture.png)

SQL queries and results travel along the client-server links

## Data Modelling and Database Design

### Data Modelling

The aim of data modelling is to

- describe what **information** is contained in the database; e.g. entities, students, courses, accounts etc.
- describe **relationships** between data items; e.g. John is enrolled in COMP3311, Tom's account is held at Coogee
- describe **constraints** on data; e.g. 7 digit IDs, students can enrol in no more than 3 courses per term

Data modelling is a design process that converts requirements into a data model. Data models can be _logical_ (i.e abstract, for conceptual design; e.g. ER models, ODL) or _physical_ (i.e record based, for implementation; e.g. relational models)

The strategy is to design using an abstract/logical model and then map to a physical model

![modelling strategy](imgs/1-30_model-strategy.png)

We can to consider the following when we design models:

- start simple - we'll evolve the design as the problem is better understood
- identify objects (and their properties), then relationships
- most designs involve kinds (classes) of people
- keywords in requirements suggest data or relationships (a rule of thumb is: nouns -> data, verbs -> relationships)
- don't confuse operations with relationships; he _buys_ a book is an **operation**, the book _is owned_ by him is a **relationship**
- consider all possible data, not just what is available

#### Design Quality

There is no single "best" design for a given application.  
Most import aspects of a design (data model) are

- **correctness** - satisfies requirements accurately
- **completeness** - all requirements are covered, all assumptions are explicit
- **consistency** - having no contradictory statements

Potential **inadequacies** in a design are those that:

- omit information that needs to be included
- contain redundant information, which leads to inconsistency
- lead to inefficient implementation
- violates syntactic or semantic rules of data models

### ER Modelling

In Entity-Relationship modelling, the world is viewed as a collection of **inter-related** entities. ER had three major modelling constructs:

- an **attribute**: a data item describing a property of interest
- an **entity**: a collection of attributes describing an object of interest
- a **relationship**: an association between entities (objects)

The ER model is not standard so many variations of it exist.

#### ER Diagrams

ER diagrams are a graphical tool for data modelling. An ER diagram consists of:

- a collection of entity set definitions
- a collection of relationship set definitions
- attributes associated with entity and relationship sets
- connections between entity and relationship sets

Note that when discussing 'entity sets', we often just call them 'entities'

Here are specific visual symbols used to indicate different ER design elements:

![ER symbols](imgs/1-36_ER-symbols.png)

Examples of ER diagrams:

![ER examples](imgs/1-37_ER-examples.jpg)

##### Entity Sets

An **entity set** can be viewed as either a set of entities with the same set of attributes (extensional) or an abstract description of a class of attributes (intensional).

A **key** or **superkey** is any set of attributes whose set of values are distinct over an entity set. The set of attributes can be natural (i.e a combination of attributes) or artificial (i.e auto-generated like a student id). You can usually determine if a attribute is a key by determining whether it's value will be shared with other entities.  
A **candidate key** is a minimal superkey; i.e no subset of the superkey is a key.  
A **primary key** is a candidate key chosen by the database designer. For each entity there is **one** primary key.  

Keys are indicated in ER diagrams using **underlines**. If multiple attributes are underlines, then the set of attributes make the key.

##### Relationship Sets

A **relationship** is an association among several entities. e.g. a Customer _is the owner of_ Account  
A **relationship set** is a collection of relationships of the same type

The **degree** of a relationship is the # of entities involved in the relationship

![ER degree](imgs/1-43_ER_degree.png)

The **cardinality** of a relationship is the # of associated entities on each side of the relationship

![ER cardinality](imgs/1-44_ER-cardinality.png)

The **participation** in a relation can be total or partial

![ER participation](imgs/1-42_ER_participation.png)

In some cases, a relationship needs associated attributes

![Relationshp attributes](imgs/1-45_relationship-attr.png)

##### Weak Entity Sets

A **weak entity exists** only because of an association with strong entities; it cannot exist without the strong entities it is associated with. They do not have key of their own, but they do have a **descriminator** which is denoted using a dotted underline or the same symbol as a derived attributes

![Weak entity](imgs/1-48_weak-entity.png)

##### Subclasses and Inheritance

A **subclass** of an entity set A is a set of entities with

- all attributes of A, plus (usually) its own attributes
- all relationships A is involved in, plus its own

Subclasses can be:

- **overlapping** or **disjoint** (can an entity be in multiple subclasses?)  
Overlapping inheritance: the entity can be this or that or both
Disjoint inheritance: the entity is must be one or the other but not both
- **total** or **partial** (does every entity have to also be in a subclass?)  
Partial participation does not have to be who inherits it.
Total participation means you cannot be the parent

![subclasses](imgs/1-50_ER-subclasses.png)

A special case of inheritance is when an entity has **one subclass**; i.e "B _is a_ A" specialisation"

![specialisation subclass](imgs/1-49_ER-specialisation-subclass.png)

##### Design Using the ER Model

ER models are a simple, powerful set of data modelling tools. Some considerations to take when designing ER models:

- should an "object" be represented by an attribute or entity?
- is a "concept" best represented as an entity or relationship?
- should we use n-way relationships or several 2-way relationships?
- is an "object" a strong or weak entity?
- are there subclasses/superclasses within the entities?

Answers to the above are worked out by _thinking_ about the application domain

For example: we have two ways to represent "a person has some types of foods that they like"

![person-likes-food](imgs/1-52_person-likes-food.png)

The option you choose depends on how you want to represent your food.  
Will it have attributes such as its ingredients and other operations done on the attributes? Then the second option is better. Do we only want to the food name and nothing else? Then the first option is better.  
Performance in this problem is not an issue as the operation in the end is _doable_ but perhaps not convenient, but this is not a design issue.

### Relational Modelling

The relational data model described the world as a collection of inter-connected _relations (or tables)_.  
The goal of a relational model is to have a simple, general data modelling _formalism_ which maps easily to file structures (i.e. implementable)

A relational model has two styles of terminology:

- mathematical: relation, tuple, attribute, etc.
- data-oriented: table, record, field/column, etc.

The relational model has one structuring mechanism:

- a _relation_ corresponds to a mathematical "relation" and can also be viewed as a "table"

Each relation (denoted R,S,T,...) has a:

- a **name** unique within a given **database**
- a **set of attributes** which can be viewed as columns or headings

Each attribute (denoted A,B,... or a1,a2,...) has:

- a **name** unique within a given **relation**
- an associated domain, which is a set of allowed values

The database definition also uses _constraints_ (logic expressions)

A tuple (row) is a set of values (attribute or column values). Attribute values:

- are **atomic** (there are no composite or multi-valued attributes). Derived attributes do not need to be modelled in a relational model
- belong to a **domain**, which has a name, data type and format. A distinguished `NULL` value belongs to all domains. A `NULL` has several interpretations; none, don't know, irrelevant

![Eample tuple](imgs/1-60_example-tuple.png)

A **relation (table)** is a set of tuples. Since a relation is a set, there is **no ordering** of rows. Normally we define a standard ordering on components of a tuple. The following are different representations of the same relation:

![Example relation](imgs/1-60_example-relation.png)

Each relation generally has a primary key (a subset of attributes, unique over the relation).

#### Expressing a Relational Data Model Mathematically

![Mathematical representation of relational model](imgs/1-62_relation-math-model.png)

## Database Application Development
