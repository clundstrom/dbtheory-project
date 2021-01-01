def sql(request_type, *args):
    """
    Composes queries based on type of request.
    """

    query = ''

    ######################
    # USER RELATED QUERIES
    ######################
    if request_type == 'GET_ALL_USERS':
        query = """ SELECT * FROM Users_Public"""

    elif request_type == 'GET_USER_BY_ID':
        query = """SELECT * FROM users WHERE id = %s"""

    elif request_type == 'GET_USER_BY_NAME':
        query = """SELECT * FROM users WHERE name like %s"""

    elif request_type == 'GET_USER_BY_TYPE':
        query = """
        SELECT name, type
        FROM users
        INNER JOIN userlevel ON users.fk_userlevel_id = userlevel.id
        WHERE type = %s
        """
    elif request_type == 'POST_REGISTER_USER':
        query = """INSERT INTO `users` (name, hash, fk_userlevel_id) VALUES(%s, %s, %s)"""

    elif request_type == 'POST_UPDATE_TOKEN':
        query = """UPDATE `users` SET token = (%s) WHERE id = (%s)"""

    elif request_type == 'POST_UPDATE_USER':
        query = """
            UPDATE `users` 
            SET hash = (%s), address = (%s), phone_number = (%s), fk_community_ids = (%s) 
            WHERE id = (%s)
            """
    elif request_type == 'DELETE_USER':
        query = """
            DELETE FROM users
            WHERE users.id = %s
            """

    ###########################
    # COMMUNITY RELATED QUERIES
    ###########################
    elif request_type == 'GET_COMMUNITY_BY_NAME':
        query = """SELECT * FROM community WHERE name like %s"""

    elif request_type == 'GET_COMMUNITY_BY_AREA':
        query = """SELECT * FROM community WHERE area like %s"""

    elif request_type == 'GET_ALL_COMMUNITIES':
        query = """SELECT * FROM community"""

    ###########################
    # COURSES
    ###########################
    elif request_type == 'GET_ALL_COURSES':
        query = """SELECT name, points, completed FROM courses"""

    elif request_type == 'GET_COMPLETED_COURSES':
        query = """
        SELECT name, points, completed FROM courses
        WHERE completed = %s
        """
    elif request_type == 'GET_SUM_COURSES':
        query = """
           SELECT sum(points) as total_points FROM courses
           WHERE completed=%s
           """
    ########################################
    # PUBLISHABLE & PROJECT RELATED QUERIES
    #######################################
    elif request_type == 'GET_PROJECT_AUTHOR':
        query = """
           SELECT name, address, phone_number FROM projects
           INNER JOIN publishable on projects.fk_parent_id = publishable.id
           INNER JOIN users on users.id = publishable.fk_author_id
           WHERE projects.fk_parent_id = %s
           """

    elif request_type == 'GET_PUBLISHABLE_AUTHOR':
        query = """
           SELECT name, address, phone_number FROM publishable
           INNER JOIN users on users.id = publishable.fk_author_id
           WHERE publishable.id = %s
           """

    elif request_type == 'GET_TOP_POSTERS':
        query = """
               SELECT author, name, address, phone_number, count(users.id) as nr_posts from publishable
               INNER JOIN users on users.id = publishable.fk_author_id
               GROUP BY users.id
               ORDER BY nr_posts DESC
               """
    elif request_type == 'GET_ALL_POSTS':
        query = """
               SELECT * FROM publishable
               """
    elif request_type == 'GET_ALL_PROJECTS':
        query = """
               SELECT * FROM projects
               INNER JOIN publishable on publishable.id = projects.fk_parent_id
               """
    elif request_type == 'GET_POSTS_HIDDEN':
        query = """
               SELECT * FROM publishable
               WHERE hidden = %s
               """
    elif request_type == 'GET_POSTS_BY_DATE':
        query = """
               SELECT *, from_unixtime(created) as timestamp from publishable
               where unix_timestamp(%s) < created AND unix_timestamp(%s) >= created
               """
    elif request_type == 'GET_ALL_PUBLISHABLE_PROJECTS':
        query = """
        SELECT * FROM publishable
        LEFT JOIN projects on publishable.id = projects.fk_parent_id
        ORDER BY publishable.id desc
        LIMIT %s
        """
    elif request_type == 'GET_POSTS_OVER_X_CHARS':
        query = """
            SELECT * FROM publishable 
            WHERE publishable.id IN
            (SELECT publishable.id FROM publishable 
            WHERE LENGTH (body) > %s)
            """

    return query
