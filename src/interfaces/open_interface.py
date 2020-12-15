def sql(request_type, *args):
    """
    Composes queries based on type of request.
    """

    query = ''

    if request_type == 'GET_ALL_USERS':
        query = """ SELECT name FROM users"""

    elif request_type == 'GET_USER_BY_ID':
        query = """SELECT * FROM users where id = %s"""

    elif request_type == 'GET_USER_BY_NAME':
        query = """SELECT * FROM users where name = %s"""

    elif request_type == 'GET_COMMUNITY_BY_NAME':
        query = """SELECT * FROM community where name like  %s"""

    elif request_type == 'GET_COMMUNITY_BY_AREA':
        query = """SELECT * FROM community where area = %s"""

    elif request_type == 'GET_ALL_COMMUNITIES':
        query = """SELECT * FROM community"""

    elif request_type == 'POST_REGISTER_USER':
        query = """INSERT INTO `users` (name, hash) VALUES(%s, %s)"""

    elif request_type == 'POST_UPDATE_TOKEN':
        query = """UPDATE `users` SET token = (%s) WHERE id = (%s)"""

    elif request_type == 'POST_UPDATE_USER':
        query ="""
            UPDATE `users` 
            SET hash = (%s), address = (%s), phone_number = (%s), fk_community_ids = (%s) 
            WHERE id = (%s)
            """

    return query
