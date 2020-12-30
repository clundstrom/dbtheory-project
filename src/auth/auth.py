import hashlib
import os
from flask import request, abort
from interfaces.open_interface import sql
from auth import connect as conn


def authenticate(func):
    """
    Decorator that wraps functions and forces authentication
    """
    def wrap(*args, **kwargs):
        if validate(request.json):
            return func(*args, **kwargs)
        else:
            return abort(403)
    return wrap


def validate(request):
    """
    Validates request by comparing token and username supplied
    in request payload.
    """
    if request is not None:
        if request.get('token') and request.get('username'):
            query = sql('GET_USER_BY_NAME')
            res = conn.execute(query, (request['username'],))
            if res.json:
                token = res.json[0].get('token')
                if token == request.get('token'):
                    return True
    return False


def hash_password(password):
    """
    Hashes password using 100k iterations of pbkdf2 algorithm.
    @param password Supplied in string format
    """
    salt = os.urandom(32)
    hash = hashlib.pbkdf2_hmac(
        'sha256',
        password.encode('utf-8'),
        salt,
        100000
    ).hex()
    salt = salt.hex()
    hash = hash + salt
    print('Generated hash: ', hash)

    return hash


def is_valid_login(password, old_hash):
    """
    Validates login by extracting salt from old hash using it to hash
    the supplied password before comparison.
    """
    salt = bytes.fromhex(old_hash[-64:])
    new_hash = hashlib.pbkdf2_hmac(
        'sha256',
        password.encode('utf-8'),
        salt,
        100000
    ).hex()
    new_hash = new_hash + salt.hex()

    return new_hash == old_hash
