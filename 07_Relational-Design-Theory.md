# Relational Design Theory

Functional dependencies describe relationships between attributes within a relation. They have implications for "good" relational schema design.

The aim is to improve understanding of relationships among data and gain enough formalism to assist practical database design.

A _good_ relational database design must capture **all** necessary attributes/associates and do this with **minimal** amount of stored information.  
Minimal stored information ⇒ no redundant data.

In database design **redundancy** is generally a "bad thing" since it causes problems maintaining consistency after updates. But, redundancy may give performance improvements; e.g. avoid a join to collect pieces of data together.

Consider the following relation defining bank accounts/branches.

![Redundancy](imgs/8-4_redundancy.jpg)

We have the following issues in the relation above:

* **insertion anomaly** - when we insert a new record, we need to check that branch data is consistent with existing tuples
* **update anomaly** - if a branch changes address, we need to update all tuples referring to that branch
* **deletion anomaly** -  if we remove information about the last account at a branch, all of the branch information disappears

The insertion and update anomalies can be handled (e.g. by triggers) but this requires extra DBMS work on every change to the database.

To avoid these kinds of update problems, we need a schema with **minimal overlap** between tables and each table contains a **coherent** collection of data values. Such schemas have little to no redundancy.

ER to SQL mappings tend to give non-redundant schemas but does not guarantee no redundancy.

The methods we describe can reduce redundancy in schemas, hence eliminating insertion and update anomalies.

A possible way to _generate_ non-redundant schemas:

1. start with a **universal relation** U (containing all relevant attributes); this schema would have maximum redundancy  
e.g Banking(accountNo, balance, customer, branch, address, assets)
2. specify how attributes relate to each other
3. **decompose** relation U into several smaller relations Ri, where each Ri has **minimal overlap** with other Rj but sufficient overlap to reconstruct the original relation
4. repeat decomposition step until no further decomposition is possible.

Typically each Ri ends up containing info about one _entity_ (e.g. a customer)

## Notation/Terminology

Most texts adopt the following terminology:

``` txt
Attributes              upper-case letters from the start of the alphabet (e.g. A, B, C, ..)
Sets of attributes      concatenation of attibute names (e.g. X=ABCD, Y=EFG)
Relation schemas        upper-case letters, denoting a set of all attributes (e.g. R)
Relation instances      lower-case letter corresponding to the schema (e.g. r(R))
Tuples                  lower-case letters (e.g. t, t', t1, u, v)
Attributes in tuples    tupler[attrSet] (e.g. t[ABCD], t[X])
```

## Functional Dependency
