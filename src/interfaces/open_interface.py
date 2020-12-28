def sql(request_type, *args):
    """
    Composes queries based on type of request.
    """

    query = ''

    # USER RELATED QUERIES
    if request_type == 'GET_ALL_USERS':
        query = """ SELECT * FROM Users_Public"""

    elif request_type == 'GET_USER_BY_ID':
        query = """SELECT * FROM users where id = %s"""

    elif request_type == 'GET_USER_BY_NAME':
        query = """SELECT * FROM users where name = %s"""

    elif request_type == 'GET_USER_PERMISSIONS':
        query = """
        SELECT name, type, permissions FROM users
        INNER JOIN userlevel ON users.fk_userlevel_id = userlevel.id
        """

    elif request_type == 'GET_USER_BY_TYPE':
        query = """
        SELECT name, type
        FROM users
        INNER JOIN userlevel ON users.fk_userlevel_id = userlevel.id
        WHERE type = %s
        """
    elif request_type == 'POST_REGISTER_USER':
        query = """INSERT INTO `users` (name, hash) VALUES(%s, %s)"""

    elif request_type == 'POST_UPDATE_TOKEN':
        query = """UPDATE `users` SET token = (%s) WHERE id = (%s)"""

    elif request_type == 'POST_UPDATE_USER':
        query = """
            UPDATE `users` 
            SET hash = (%s), address = (%s), phone_number = (%s), fk_community_ids = (%s) 
            WHERE id = (%s)
            """

    # COMMUNITY RELATED QUERIES
    elif request_type == 'GET_COMMUNITY_BY_NAME':
        query = """SELECT * FROM community where name like %s"""

    elif request_type == 'GET_COMMUNITY_BY_AREA':
        query = """SELECT * FROM community where area like %s"""

    elif request_type == 'GET_ALL_COMMUNITIES':
        query = """SELECT * FROM community"""

    return query
