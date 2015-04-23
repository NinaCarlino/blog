---
title: Saving Secrets with Flask-SQLAlchemy
date: 2015/04/15
author: Jason
tags: Symmetric Encryption, Flask, SQLAlchemy, Hybrid Properties
published: false
---

In a previous blog post we featured the Fernet class of the cryptography module. This time we'll be persisting encrypted data to a database using Flask-SQLAlchemy. This blog post stresses the importance of application level encryption.


##### Saving data with Flask-SQLAlchemy (my favorite)


```python

from sqlalchemy.ext.hybrid import hybrid_property

class Diary(db.Model):
    __enc_entry = db.Column(db.Binary)

    @hybrid_property
    def entry(self):
        return decrypt(self.__enc_entry)

    @entry.setter
    def entry(self, value):
        self.__enc_entry = encrypt(value)

```

There is a lot going on here. Let's make sense of it all.

Here we set up a ```Diary``` table with one column called ```__enc_entry``` that takes binary data, and two other "things".

These other "things" are one of SQLAlchemy's coolest features:

###### Hybrid property

Note the double underscore which indicates a "private" attribute/method of a Python object. The only two places that the "__enc_entry"
