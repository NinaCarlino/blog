---
title: Keeping Secrets Secret in Python
date: 2015/04/14
author: Jason
tags: Symmetric Encryption
published: true
---

Securing data is hard. The methods are scattered. The vulnerabilities are a nightmare.

Enter Python's [cryptography module](https://cryptography.io/en/latest/).

This post will focus on [Fernet](https://cryptography.io/en/latest/fernet/) within the [cryptography module](https://cryptography.io/en/latest/). Cryptography's Fernet classes enable us to quickly and easily setup symmetric encryption with just a few lines of code.

The Fernet class's API is extremely simple. Fernet has one `classmethod` called `generate_key()` and two instance methods `encrypt(plaintext_binary)` and `decrypt(cipher_binary)`.

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

Keeping secrets as environment variables is a more secure alternative than putting them into source control. It's not fool proof, though. Be aware of the [risks and best practices](http://stackoverflow.com/questions/12461484/is-it-secure-to-store-passwords-as-environment-variables-rather-than-as-plain-t) and make sure to research the a method that works best for your use case..

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

That's all for now. Next time I hope to outline the use of some of SQLAlchemy's advanced features to use these functions to easily persist secure data to a database.
