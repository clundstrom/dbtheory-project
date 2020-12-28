def status_code(code=None):
    codes = {
        200: "OK",
        201: "Created",
        403: "Bad password"
    }
    return {"message": codes.get(code, "")}


def status_custom(custom):
    return {"message": custom}