from flask import Blueprint, request, make_response, abort
from auth.auth import authenticate
from models.http import status_code, status_custom
from auth import connect as conn
from interfaces.open_interface import sql
from auth import auth
import secrets

open_routes = Blueprint('open_routes', __name__)
DEFAULT_PERMISSION = 1


@open_routes.route("/test", methods=['GET'])
def test():
    return make_response(status_custom("Connection OK"), 200)


@open_routes.route("/test_auth", methods=['GET'])
@authenticate
def test_auth():
    return make_response(status_custom("Authorized"), 200)


@open_routes.route("/courses", methods=['GET'])
def courses():

    if request.args.get('completed') and request.args.get('sum') == '1':
        query = sql('GET_SUM_COURSES')
        res = conn.execute(query, request.args.get('completed'))

    elif request.args.get('completed'):
        query = sql('GET_COMPLETED_COURSES')
        res = conn.execute(query, request.args.get('completed'))

    else:
        query = sql("GET_ALL_COURSES")
        res = conn.execute(query)

    return make_response(res, 200)


@open_routes.route("/user", methods=['GET', 'DELETE'])
def user():
    if request.method == 'GET':
        if request.args.get('id'):
            query = sql('GET_USER_BY_ID', request.args.get('id'))
            res = conn.execute(query, request.args.get('id'))
        else:
            query = sql(request_type='GET_ALL_USERS')
            res = conn.execute(query)
    elif request.method == 'DELETE':
        if request.args.get('id'):
            query = sql('DELETE_USER', request.args.get('id'))
            conn.execute(query, request.args.get('id'))
            return make_response(status_custom("User deleted"), 200)
        else:
            return make_response(status_code(400), 400)
    return make_response(res, 200)


@open_routes.route("/community", methods=['GET'])
def communities():
    if request.args.get('area'):
        query = sql('GET_COMMUNITY_BY_AREA')
        res = conn.execute(query, request.args.get('area'))

    elif request.args.get('name'):
        query = sql('GET_COMMUNITY_BY_NAME')
        likeStr = "%" + request.args.get('name') + "%"
        res = conn.execute(query, likeStr)

    else:
        query = sql('GET_ALL_COMMUNITIES')
        res = conn.execute(query)

    return make_response(res, 200)


@open_routes.route("/register", methods=['POST'])
def register():
    """
    Handles registration of users. Works by supplying a json object in the POST request body.
    Example:

    {
    "username": "Chris",
    "password": "secretpassword"
    }
    """
    data = request.json
    if data.get('username') and data.get('password'):
        query = sql('GET_USER_BY_NAME', data.get('username'))
        res = conn.execute(query, data.get('username'))

        if len(res.json) != 1:
            hash = auth.hash_password(password=data.get('password'))
            query = sql('POST_REGISTER_USER', data.get('username'), hash)
            conn.execute(query, data.get('username'), hash, DEFAULT_PERMISSION)
            return make_response(status_custom("Registration successful"), 200)
    else:
        return abort(400)
    return make_response(status_custom("Username taken"), 400)


@open_routes.route("/login", methods=['POST'])
def login():
    """
    Handles login of a user and returns a session_token if supplied password and username is correct.
    Token and Username needs to be supplied with every request in order to access restricted routes.

    Example:
    {
    "username": "Chris",
    "token": "0e45b5df2e6c42ae9b69f1a2a2470209"
    }
    """

    data = request.json

    if data.get('username') and data.get('password'):
        query = sql('GET_USER_BY_NAME', data.get('username'))
        user = conn.execute(query, data.get('username')).json
        if not user:
            return make_response(status_custom("No such user"), 200)
        user = user[0]
        if auth.is_valid_login(data.get('password'), user.get('hash')):
            token = secrets.token_urlsafe(64)
            query = sql('POST_UPDATE_TOKEN')
            conn.execute(query, token, user.get('id'))
            user = {"username": user.get('name'),
                    "token": token
                    }
            return make_response(user, 200)

        else:
            return make_response(status_code(403), 403)
    return abort(400)
