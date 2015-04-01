---
title: "Size Constrained One-To-Many with SQLAlchemy"
date: 2015/03/31
author: Jason
tags: Flask-SQLAlchemy, SQLAlchemy
published: true
---

A recent project of ours required a one-to-many relation in SQLAlchemy. What made this relationship different was that **the size of the relation needed to be less than four**.

To illustrate our solution, we will create a `Farmer` entity that has many `BlindMouse` entities. We throw a custom exception if an attempt is made to add more than the allowed number of records that can be associated with the foreign key of the `Farmer`.

The following uses Flask-SQLAlchemy, but can just as easily be implemented in standard SQLAlchemy.

We are given the following tables:

```python

class Farmer(db.Model):
    __tablename__ = "farmer"
    id = db.Column(db.Integer, primary_key=True)

```

and

```python

class BlindMouse(db.Model):
    __tablename__ = "blindmouse"
    id = db.Column(db.Integer, primary_key=True)
    farmer = db.relationship('Farmer', backref='blind_mice')
    farmer_id = db.Column(db.Integer, db.ForeignKey('farmer.id'))

```

Then we create a custom error.

```python
from sqlalchemy.exc import IntegrityError

    class RelationLimitReachedError(IntegrityError):
        pass
```

Using SQLAlchemy's ```@event``` decorator and our new ```RelationLimitReachedError``` exception we set up a limit checker.

```python

from sqlalchemy import event


@event.listens_for(BlindMouse.farmer_id, 'set', retval=True)
def blindmouse_per_farmer_limit_check(target, value, oldvalue, initiator):
    if value is not None:
        mouse_count = BlindMouse.query.filter_by(farmer_id=value).count()
        if mouse_count >= 3:
            err = 'Max number of BlindMouses (3) reached for Farmer {}'
            orig = Exception(err.format(value))
            msg = "Record Not Committed"
            last_part = 'Session Rolled Back and Cursor Flushed'
            raise RelationLimitReachedError(msg, last_part, orig)
    return value

```

If the addition of a new `BlindMouse` to the `Farmer` exceeds our limit (3) an `IntegrityError` is raised and the new `BlindMouse` is not added.

For a simple working example, follow the instructions in [this repo](https://github.com/elbow-jason/three-blind-mice). As always, questions are welcome.
