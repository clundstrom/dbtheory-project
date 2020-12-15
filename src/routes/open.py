from flask import Blueprint, request, make_response, abort
from auth.auth import authenticate
from models.http import status_code, status_custom
from auth import connect as conn
from interfaces.open_interface import sql
from auth import auth
import uuid

open_routes = Blueprint('open_routes', __name__)


@open_routes.route("/test", methods=['GET'])
def test():
    return make_response(status_custom("Connection OK"), 200)


@open_routes.route("/test_auth", methods=['GET'])
@authenticate
def test_auth():
    return make_response(status_custom("Authorized"), 200)


@open_routes.route("/get_user/", methods=['GET'])
def get_user():
    if request.args.get('id'):
        id = request.args.get('id')
        query = sql('GET_USER_BY_ID', request.args.get('id'))
        res = conn.execute(query, id)
    else:
        query = sql(request_type='GET_ALL_USERS')
        res = conn.execute(query)

    return make_response(res, 200)


@open_routes.route("/abort", methods=['GET'])
def get_abort():
    return abort(404)


@open_routes.route("/community", methods=['GET'])
def get_communities():

    if request.args.get('area'):
        query = sql('GET_COMMUNITY_BY_AREA')
        res = conn.execute(query, request.args.get('area'))

    elif request.args.get('name'):
        query = sql('GET_COMMUNITY_BY_NAME')
        likeStr = "%" + request.args.get('name') +"%"
        res = conn.execute(query, likeStr)

    else:
        query = sql('GET_ALL_COMMUNITIES')
        res = conn.execute(query)

    return make_response(res, 200)


@open_routes.route("/register", methods=['POST'])
def register():
    data = request.json
    if data.get('username') and data.get('password'):
        query = sql('GET_USER_BY_NAME', data.get('username'))
        res = conn.execute(query, data.get('username'))

        if len(res.json) != 1:
            hash = auth.hash_password(password=data.get('password'))
            query = sql('POST_REGISTER_USER', data.get('username'), hash)
            conn.execute(query, data.get('username'), hash)
            user = {
                "username": data.get('username'),
                "password": data.get('password')
            }
            return login(user)
    else:
        return abort(400)
    return make_response(status_custom("Registration successful"), 200)


def login(param):
    if param:
        data = param
    else:
        data = request.json

    if data.get('username') and data.get('password'):
        query = sql('GET_USER_BY_NAME', data.get('username'))
        user = conn.execute(query, data.get('username')).json
        if not user:
            return make_response(status_custom("No such user"), 200)
        user = user[0]
        if auth.is_valid_login(data.get('password'), user[2]):
            token = uuid.uuid4().hex
            query = sql('POST_UPDATE_TOKEN')
            conn.execute(query, token, user[0])
            user = {"username": user[1],
                    "token": token
                    }
            return make_response(user, 200)

        else:
            return make_response(status_code(200), 200)
    return abort(400)
