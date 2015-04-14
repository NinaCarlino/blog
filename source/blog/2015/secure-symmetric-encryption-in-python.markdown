---
title: Keep Your Secrets Secret
date: 2015/04/14
author: Jason
tags: Symmetric Encryption
published: false
---

Securing data is hard. The methods are scattered. The vulnerabilities are a nightmare. Ideally, one would like a simple yet effective way to secure data.

Enter Python's [cryptography module](https://cryptography.io/en/latest/).

The [cryptography module](https://cryptography.io/en/latest/) contains many useful tools. We will focus on [Fernet](https://cryptography.io/en/latest/fernet/) and [MultiFernet](https://cryptography.io/en/latest/fernet/#cryptography.fernet.MultiFernet). Cryptography's Fernet classes enable us to quickly and easily setup symmetric encryption with just a few lines of code.

The Fernet class's API is extremely simple. Fernet has one ```classmethod``` called ```generate_key()``` and two instance methods ```encrypt(plaintext_binary)``` and ```decrypt(cipher_binary)```.

##### The Setup

Generate a key and save it to the OS's environment variables:

```python

>>> from cryptography.fernet import Fernet
>>> key = Fernet.generate_key()
>>> key
'BP04_l7C3wByNiEaEiseNiP0ZrqZ7s3qL-mkG8eHlJY='

```

This is an example key. The key generated here should be saved in a secure place. Keep it secret. Keep it safe.

Add the key to your environment variables:

```bash
$ SECRET_FERNET_KEY='BP04_l7C3wByNiEaEiseNiP0ZrqZ7s3qL-mkG8eHlJY='
```

Note: There are many clever ways to get the key into the environment variables. Just make sure it's secure.

##### The Functions

```python

from cryptography.fernet import Fernet
import os

crypto = Fernet(os.environ.get('SECRET_FERNET_KEY'))

def encrypt(plain_text):
    if isinstance(plain_text, basestring):
        string_text = str(plain_text)
        return crypto.encrypt(bytes(string_text))
    else:
        raise Exception('Encryption Error. Only strings are allowed.')

def decrypt(cipher_text):
    return crypto.decrypt(cipher_text)

```

The above functions are abstractions around the Fernet instance object. The reason for enforcing strings as input to the ```encrypt``` function is that the ```decrypt``` method of the Fernet instance object (```crypto``` in this case) will only ever return strings and having a consistent API for input and output is important for avoiding incorrect type issues.

##### Try It Out

```python

encrypted_spoiler = encrypt('Snape kills Dumbledore.')
print encrypted_spoiler
# gAAAAABVLTmsBrJWKMzjn4pDlRwtk1j3TFcF1lrRlXo8_ASbR42vEiAcagNKR3cqp6ypSdPPyMozGi2T10pxqKISxwVYqMqoEIaScr310glx55vUk_l6eLc=


plaintext_spoiler = decrypt(encrypted_spoiler)
print plaintext_spoiler
# Snape kills Dumbledore.

```

That's all for now. Next time I hope to outline the use of some of SQLAlchemy's advanced features to use these functions to easily persist data to a database.
