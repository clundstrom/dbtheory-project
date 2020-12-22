DROP DATABASE IF EXISTS general;
CREATE DATABASE IF NOT EXISTS general;
USE general;

CREATE TABLE IF NOT EXISTS `userlevel` (
    `id` int(10) NOT NULL AUTO_INCREMENT,
    `type` varchar(50) DEFAULT NULL,
    `permissions` varchar(128) DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `users` (
    `id` int(10) NOT NULL  AUTO_INCREMENT,
    `name` varchar(50) NOT NULL,
    `hash` varchar(128) DEFAULT NULL,
    `address` varchar(82) DEFAULT NULL,
    `phone_number` varchar(82) DEFAULT NULL,
    `token` varchar(128) DEFAULT NULL,
    `fk_userlevel_id` int(10) NOT NULL,
    `fk_community_ids` varchar(20) DEFAULT NULL,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`fk_userlevel_id`)
        REFERENCES `userlevel`(`id`),
    INDEX (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `community` (
    `id` int(10) NOT NULL AUTO_INCREMENT,
    `name` varchar(50) DEFAULT NULL,
    `area` varchar(50) DEFAULT NULL,
    `fk_owner_id` int(10),
    PRIMARY KEY (`id`),
    FOREIGN KEY (`fk_owner_id`)
        REFERENCES `users`(`id`)
        ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `products` (
    `id` int(10) NOT NULL AUTO_INCREMENT,
    `name` varchar(50) DEFAULT NULL,
    `description` varchar(100) DEFAULT NULL,
    `count` int(10),
    `available` boolean,
    `fk_community_id` int(10) DEFAULT NULL,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`fk_community_id`)
        REFERENCES `community`(`id`)
        ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `publishable` (
    `id` int(10) NOT NULL AUTO_INCREMENT,
    `author` varchar(50) DEFAULT NULL,
    `created` int(20) DEFAULT NULL,
    `dateString` varchar(30) DEFAULT NULL,
    `title` varchar(50) DEFAULT NULL,
    `message` longtext DEFAULT NULL,
    `imageURL` varchar(100) DEFAULT NULL,
    `hidden` boolean,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `courses` (
    `id` int(10) NOT NULL AUTO_INCREMENT,
    `name` varchar(50) DEFAULT NULL,
    `points` float(10) DEFAULT NULL,
    `start` varchar(50) DEFAULT NULL,
    `end` varchar(50) DEFAULT NULL,
    `active` boolean DEFAULT NULL,
    `completed` boolean DEFAULT NULL,
    `next` boolean DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `projects` (
    `id` int(10) NOT NULL AUTO_INCREMENT,
    `tags` varchar(50) DEFAULT NULL,
    `srcURL` varchar(255) DEFAULT NULL,
    `fullPageImageUrl` varchar(255) DEFAULT NULL,
    `description` varchar(100) DEFAULT NULL,
    `fk_parent_id` int(10) DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

# Insert some default userlevels
INSERT INTO `userlevel` (`type`, `permissions`) VALUES ('Admin', 0);
INSERT INTO `userlevel` (`type`, `permissions`) VALUES ('Mod', 1);
INSERT INTO `userlevel` (`type`, `permissions`) VALUES ('Member', 2);
INSERT INTO `userlevel` (`type`, `permissions`) VALUES ('Guest', 3);

# Insert some default test users
INSERT INTO `users` (`name`, `fk_userlevel_id`,`fk_community_ids`) VALUES("LuRRE",1, "[1,2]");
INSERT INTO `users` (`name`, `fk_userlevel_id`,`fk_community_ids`) VALUES("Ditch", 2,"[1,2]");
INSERT INTO `users` (`name`, `fk_userlevel_id`,`fk_community_ids`) VALUES("Bob",3,"[3]");
INSERT INTO `users` (`name`, `fk_userlevel_id`,`fk_community_ids`) VALUES("Preben", 4,"[]");

# Insert some default test communities
INSERT INTO `community` (`name`, `area`, `fk_owner_id`) VALUES("Lurres hammerdrills", "Stockholm", 1);
INSERT INTO `community` (`name`, `area`, `fk_owner_id`) VALUES("Ditch's lawnmowers", "Kalmar", 2);
INSERT INTO `community` (`name`, `area`, `fk_owner_id`) VALUES("Bobs borrowing burrow", "Göteborg",3);
INSERT INTO `community` (`name`, `area`, `fk_owner_id`) VALUES("Admin", "Jönköping", 4);

# Insert some default test products
INSERT INTO `products` (`name`, `description`, `count`, `available`, `fk_community_id`) VALUES("Bosch 2k 400W", "Finest slagborrmachine on the market", 1, true, 1);

# Insert some default test publishable


# Insert some default test projects
INSERT INTO `projects` (`tags`, `srcURL`, `fullPageImageUrl`,`description`,`fk_parent_id`)
VALUES('["Python", "Gradient Descent", "Machine Learning"]',
       'https://github.com/clundstrom/dimensionality_reduction',
       'https://firebasestorage.googleapis.com/v0/b/portfolio-416e3.appspot.com/o/images%2F1605214298232_dr.png?alt=media&token=66417fd2-dd85-46e6-b7f3-cd41cb80d5b4',
       'Machine learning project',
       NULL
);

# Insert some default courses
INSERT INTO `courses` (`name`,`points`,`start`,`end`,`active`,`completed`,`next`) VALUES('Basic Mathematics for Engineers', 7.5, NULL,NULL,False,True, False);
INSERT INTO `courses` (`name`,`points`,`start`,`end`,`active`,`completed`,`next`) VALUES('Computer Networks', 7.5, NULL,NULL,False,True, False);
INSERT INTO `courses` (`name`,`points`,`start`,`end`,`active`,`completed`,`next`) VALUES('Computer Technology', 7.5, NULL,NULL,False,True, False);
INSERT INTO `courses` (`name`,`points`,`start`,`end`,`active`,`completed`,`next`) VALUES('Database Theory ', 7.5, NULL,NULL,True,False, False);
INSERT INTO `courses` (`name`,`points`,`start`,`end`,`active`,`completed`,`next`) VALUES('Discrete Mathematics', 7.5, NULL,NULL,False,True, False);
INSERT INTO `courses` (`name`,`points`,`start`,`end`,`active`,`completed`,`next`) VALUES('Electricity and Magnetism', 7.5, NULL,NULL,False,True, False);
INSERT INTO `courses` (`name`,`points`,`start`,`end`,`active`,`completed`,`next`) VALUES('Embedded Systems Dependability', 7.5, NULL,NULL,False,True, False);
INSERT INTO `courses` (`name`,`points`,`start`,`end`,`active`,`completed`,`next`) VALUES('Embedded Systems Project', 7.5, NULL,NULL,False,False, True);
INSERT INTO `courses` (`name`,`points`,`start`,`end`,`active`,`completed`,`next`) VALUES('Engineering Economics', 7.5, NULL,NULL,False,True, False);
INSERT INTO `courses` (`name`,`points`,`start`,`end`,`active`,`completed`,`next`) VALUES('Environmental Technology', 7.5, NULL,NULL,True,False, False);
INSERT INTO `courses` (`name`,`points`,`start`,`end`,`active`,`completed`,`next`) VALUES('Introduction to Machine Learning', 7.5, NULL,NULL,False,True, False);
INSERT INTO `courses` (`name`,`points`,`start`,`end`,`active`,`completed`,`next`) VALUES('Linear Algebra for Engineers', 7.5, NULL,NULL,False,True, False);
INSERT INTO `courses` (`name`,`points`,`start`,`end`,`active`,`completed`,`next`) VALUES('Objectoriented Analysis and Design', 7.5, NULL,NULL,False,True, False);
INSERT INTO `courses` (`name`,`points`,`start`,`end`,`active`,`completed`,`next`) VALUES('Operating Systems', 7.5, NULL,NULL,False,True, False);
INSERT INTO `courses` (`name`,`points`,`start`,`end`,`active`,`completed`,`next`) VALUES('Problem Solving and Programming', 7.5, NULL,NULL,False,True, False);
INSERT INTO `courses` (`name`,`points`,`start`,`end`,`active`,`completed`,`next`) VALUES('Programming and Data Structures', 7.5, NULL,NULL,False,True, False);
INSERT INTO `courses` (`name`,`points`,`start`,`end`,`active`,`completed`,`next`) VALUES('Project course in Computer Science', 7.5, NULL,NULL,False,True, False);
INSERT INTO `courses` (`name`,`points`,`start`,`end`,`active`,`completed`,`next`) VALUES('Software Architecture', 7.5, NULL,NULL,False,False, True);
INSERT INTO `courses` (`name`,`points`,`start`,`end`,`active`,`completed`,`next`) VALUES('Software Engineering - Design', 7.5, NULL,NULL,False,True, False);
INSERT INTO `courses` (`name`,`points`,`start`,`end`,`active`,`completed`,`next`) VALUES('Software engineering introduction and project', 7.5, NULL,NULL,False,True, False);
INSERT INTO `courses` (`name`,`points`,`start`,`end`,`active`,`completed`,`next`) VALUES('Software for Embedded Systems', 7.5, NULL,NULL,False,True, False);
INSERT INTO `courses` (`name`,`points`,`start`,`end`,`active`,`completed`,`next`) VALUES('Software Technology', 7.5, NULL,NULL,False,True, False);
INSERT INTO `courses` (`name`,`points`,`start`,`end`,`active`,`completed`,`next`) VALUES('Software technology - Degree project', 7.5, NULL,NULL,False,False, False);


