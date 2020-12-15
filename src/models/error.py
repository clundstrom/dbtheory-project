from flask import jsonify
from routes.open import open_routes


@open_routes.errorhandler(400)
def bad_request(e='Bad request'):
    return jsonify(error=str(e)), 400


@open_routes.errorhandler(401)
def unauthorized(e='Unauthorized'):
    return jsonify(error=str(e)), 401


@open_routes.errorhandler(403)
def forbidden(e='Forbidden'):
    return jsonify(error=str(e)), 403


@open_routes.errorhandler(404)
def not_found(e='Not found'):
    return jsonify(error=str(e)), 404


@open_routes.errorhandler(500)
def interal_server_error(e='Internal server error'):
    return jsonify(error=str(e)), 500
