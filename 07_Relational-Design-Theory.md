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
Relation schemas        upper-case letters, denoting a set of all attributes (e.g. R)'
Relation instances      lower-case letter corresponding to the schema (e.g. r(R))
Tuples                  lower-case letters (e.g. t, t', t1, u, v)
Attributes in tuples    tupler[attrSet] (e.g. t[ABCD], t[X])
```

## Functional Dependency

A relation instance r(R) satisfies a dependency X → Y if  
for any t, u ∈ r, t[X] = u[X] ⇒ t[Y] = u[Y]

In other words, if two tuples in R agree in their values for the set of attributes X, then they must also agree in their values for the set of attributes Y.  
We say "_Y is functionally dependent on X_"

Attribute sets X and Y may overlap; and trivially it is true that X → X.

Notes:

* X → Y can also be read a s"_X determines Y_"
* the single arrow → denotes **functional dependency** (_fd_)
* the double arrow ⇒ denotes logical implication

Consider the following (redundancy-laden) schema:

``` txt
Title         | Year | Len | Studio    | Star
--------------+------+-----+-----------+---------------
King Kong     | 1933 | 100 | RKO       | Fay Wray
King Kong     | 1976 | 134 | Paramount | Jessica Lange
King Kong     | 1976 | 134 | Paramount | Jeff Bridges
Mighty Ducks  | 1991 | 104 | Disney    | Emilio Estevez
Wayne's World | 1995 | 95  | Paramount | Dana Carvey
Wayne's World | 1995 | 95  | Paramount | Mike Meyers
```
One functional dependencies:  
`Title Year → Len`, `Title Year → Studio`  
Not a functional dependency:  
`Title Year ↛ Star`

Consider an instance r(R) of the relation schema R(ABCDE):

| A   | B   | C   | D   | E   |
| --- | --- | --- | --- | --- |
| a1  | b1  | c1  | d1  | e1  |
| a2  | b1  | c2  | d2  | e1  |
| a3  | b2  | c1  | d1  | e1  |
| a4  | b2  | c2  | d2  | e1  |
| a5  | b3  | c3  | d1  | e1  |

Since A values are unique, the definitions of functional dependency gives:  
`A → B`, `A → C`, `A → D`, `A → E`, or `A → BCDE`  
Since all E values are the same, it follows that:  
`A → E`, `B → E`, `C → E`, `D → E`

Other observations:

* combinations of BC are unique, therefore BC → ADE
* combinations of BD are unique, therefore BD → ACE
* if C values match, so do D values, therefore C → D
* however D values do not determine C values so !(D → C)

We could derive many other dependencies; e.g. AE → BC

In practice, we choose the minimal set of _fd_s (basis) from which all other _fd_s can be derived, which captures useful problem-domain information.

More important for design is dependency across all possible instances of the relation (i.e schema-based dependency).  
This is a simple generalisation of the previous definition  
for any t, u ∈ **any** r, t[X] = u[X] ⇒ t[Y] = u[Y]  
such dependencies capture semantics of the problem domain.

Generalising some ideas about functional dependency:

* are there dependencies that hold for _any_ relation?  
Yes, but they are generally trivial; e.g. Y ⊂ X ⇒ X → Y
* do some dependencies suggest the existence of others?  
Yes, **rules of inference** allow us to _derive_ dependencies. They allow us to reason about sets of functional dependencies

## Inference Rules

_Armstrong's rules_ are general rules of inference on functional dependencies

**F1. Reflexivity** e.g. X → X; a formal statement of trivial dependencies; useful for derivations  
**F2. Augmentation** e.g. X → Y ⇒ XZ → XY; if a dependency holds then we can expand its left hand side (along with the right hand side)  
**F3. Transivity** e.g. X → Y, Y → Z ⇒ X → Z; the "most powerful" inference rule; useful in multi-step derivations

Armstrong's rules are complete, but other useful rules exist:  
**F4. Additivity**  
**F5. Projectivity**  
**F6. Pseudotransitivity**  
