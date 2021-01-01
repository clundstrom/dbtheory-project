DROP DATABASE IF EXISTS general;
CREATE DATABASE IF NOT EXISTS general;
USE general;

CREATE TABLE IF NOT EXISTS `userlevel` (
    `id` int(10) NOT NULL AUTO_INCREMENT,
    `type` varchar(50) NOT NULL,
    `permissions` varchar(128) NOT NULL,
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `products` (
    `id` int(10) NOT NULL AUTO_INCREMENT,
    `product` varchar(50) DEFAULT NULL,
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
    `alias` varchar(50) DEFAULT NULL,
    `created` int(20) NOT NULL,
    `dateString` varchar(30) DEFAULT NULL,
    `title` varchar(50) NOT NULL,
    `body` longtext DEFAULT NULL,
    `imageURL` varchar(255) DEFAULT NULL,
    `hidden` boolean NOT NULL,
    `fk_alias_id` int(20) NOT NULL,
    PRIMARY KEY (`id`),
    FOREIGN KEY(`fk_alias_id`)
        REFERENCES `users`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `courses` (
    `id` int(10) NOT NULL AUTO_INCREMENT,
    `name` varchar(50) NOT NULL,
    `points` float(10) NOT NULL,
    `start` varchar(50) DEFAULT NULL,
    `end` varchar(50) DEFAULT NULL,
    `active` boolean NOT NULL,
    `completed` boolean NOT NULL,
    `next` boolean NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `projects` (
    `tags` varchar(50) DEFAULT NULL,
    `srcURL` varchar(255) DEFAULT NULL,
    `fullPageImageUrl` varchar(255) DEFAULT NULL,
    `description` varchar(100) DEFAULT NULL,
    `fk_parent_id` int(10) NOT NULL,
    FOREIGN KEY (`fk_parent_id`)
        REFERENCES `publishable`(`id`)
        ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

# Insert some default userlevels
INSERT INTO `userlevel` (`type`, `permissions`) VALUES ('Admin', 0);
INSERT INTO `userlevel` (`type`, `permissions`) VALUES ('Mod', 1);
INSERT INTO `userlevel` (`type`, `permissions`) VALUES ('Member', 2);
INSERT INTO `userlevel` (`type`, `permissions`) VALUES ('Guest', 3);

# Insert some default test users
INSERT INTO `users` (`name`, `fk_userlevel_id`,`fk_community_ids`) VALUES("Christoffer Lundström",1, "[1,2]");
INSERT INTO `users` (`name`, `fk_userlevel_id`,`fk_community_ids`) VALUES("Jane Austin", 2,"[1,2]");
INSERT INTO `users` (`name`, `fk_userlevel_id`,`fk_community_ids`) VALUES("Bob Barker",3,"[3]");
INSERT INTO `users` (`name`, `fk_userlevel_id`,`fk_community_ids`) VALUES("Brent Barker",3,"[3]");
INSERT INTO `users` (`name`, `fk_userlevel_id`,`fk_community_ids`) VALUES("Tomas the tank engine", 4,"[]");

# Insert some default test communities
INSERT INTO `community` (`name`, `area`, `fk_owner_id`) VALUES("Christoffers bostadsrättsförening", "Stockholm", 1);
INSERT INTO `community` (`name`, `area`, `fk_owner_id`) VALUES("Mickes BRF", "Stockholm", 4);
INSERT INTO `community` (`name`, `area`, `fk_owner_id`) VALUES("Labans bostadsrättsförening", "Kalmar", 2);
INSERT INTO `community` (`name`, `area`, `fk_owner_id`) VALUES("Bobs bostadsrättsförening", "Göteborg",3);

# Insert some default test products
INSERT INTO `products` (`product`, `description`, `count`, `available`, `fk_community_id`) VALUES("Bosch 2k 400W", "Finest hammerdrill on the market", 1, true, 1);
INSERT INTO `products` (`product`, `description`, `count`, `available`, `fk_community_id`) VALUES("Generic Lawnmower", "Finest slagborrmachine on the market", 1, false, 1);
INSERT INTO `products` (`product`, `description`, `count`, `available`, `fk_community_id`) VALUES("Air compressor", "MAX 5 bar", 1, true, 1);

INSERT INTO `products` (`product`, `description`, `count`, `available`, `fk_community_id`) VALUES("Bosch 2k 400W", "Finest slagborrmachine on the market", 1, true, 2);
INSERT INTO `products` (`product`, `description`, `count`, `available`, `fk_community_id`) VALUES("Generic Lawnmower", "Finest slagborrmachine on the market", 1, true, 2);

INSERT INTO `products` (`product`, `description`, `count`, `available`, `fk_community_id`) VALUES("Pressure washer", "A must have for any house owner xD", 2, false, 3);
INSERT INTO `products` (`product`, `description`, `count`, `available`, `fk_community_id`) VALUES("Gardening tools", "Shovel, rake, scythe? I dno..",3, 1, true, 3);


# Insert some default test publishable
INSERT INTO `publishable` (alias, fk_alias_id, created, dateString, title, body, imageURL, hidden) VALUES ("Cyberpunkdude 69", 1, 1609148784,NULL,"Dimensionality Reduction", "The plot describes the amount of volume needed to cover r amount of samples in different dimensions. By increasing dimensions the volume needed to cover the initial 20% becomes 45% for 2D, 80% for 7D and so on.", "https://firebasestorage.googleapis.com/v0/b/portfolio-416e3.appspot.com/o/thumbnails%2Fswiss_roll.png?alt=media&token=74d84918-6ac9-4507-9efa-75d372868531", False);
INSERT INTO `publishable` (alias, fk_alias_id, created, dateString, title, body, imageURL, hidden) VALUES ("Secret Jane", 2,1609149225,NULL,"MemeCaption", "A python+flask learning project.", "https://firebasestorage.googleapis.com/v0/b/portfolio-416e3.appspot.com/o/thumbnails%2Fswiss_roll.png?alt=media&token=74d84918-6ac9-4507-9efa-75d372868531", False);
INSERT INTO `publishable` (alias, fk_alias_id, created, dateString, title, body, imageURL, hidden) VALUES ("Secret Jane", 2,1609120225,NULL,"Work on some stuff", "This is a test entry for a blogpost with a NULL imageURL.", NULL, False);
INSERT INTO `publishable` (alias, fk_alias_id, created, dateString, title, body, imageURL, hidden) VALUES ("Secret Jane", 2,1609111225,NULL,"Draft1", "Hidden draft1", NULL, True);
INSERT INTO `publishable` (alias, fk_alias_id, created, dateString, title, body, imageURL, hidden) VALUES ("Secret Jane", 2,1609110225,NULL,"Draft2", "Hidden draft2", NULL, True);
INSERT INTO `publishable` (alias, fk_alias_id, created, dateString, title, body, imageURL, hidden) VALUES ("Cyberpunkdude 69", 1,1609109225,"","Draft3", "Hidden draft3", NULL, True);
INSERT INTO `publishable` (alias, fk_alias_id, created, dateString, title, body, imageURL, hidden) VALUES ("Cyberpunkdude 69", 1,1608409225,"","The intricacies of dank memes", "You might've heard of monkaS, PEPEGA, PEPW or POGG. Today we will dig deep down the meme swamp.. Lorem ipsum Lorem ipsum Lorem ipsum.", NULL, True);

# Insert some default test projects
INSERT INTO `projects` (`tags`, `srcURL`, `fullPageImageUrl`,`description`,`fk_parent_id`)
VALUES('["Flask", "Python", "Memes", "Learning"]',
       'https://github.com/clundstrom/memecaption_api',
       'https://firebasestorage.googleapis.com/v0/b/portfolio-416e3.appspot.com/o/images%2F1605210737260_api.jpg?alt=media&token=a91e78e1-83f6-409f-b772-95827b6cb98e',
       'API for captioning memes',
       2
);

INSERT INTO `projects` (`tags`, `srcURL`, `fullPageImageUrl`,`description`,`fk_parent_id`)
VALUES('["Python", "Gradient Descent", "Machine Learning"]',
       'https://github.com/clundstrom/dimensionality_reduction',
       'https://firebasestorage.googleapis.com/v0/b/portfolio-416e3.appspot.com/o/images%2F1605214298232_dr.png?alt=media&token=66417fd2-dd85-46e6-b7f3-cd41cb80d5b4',
       'Machine learning project',
       1
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
INSERT INTO `courses` (`name`,`points`,`start`,`end`,`active`,`completed`,`next`) VALUES('Software technology - Degree project', 15, NULL,NULL,False,False, False);


# Creating view for basic user information to encapsulate sensitive data
CREATE VIEW Users_Public AS SELECT name, fk_userlevel_id, fk_community_ids, type, permissions FROM users INNER JOIN userlevel u ON users.fk_userlevel_id = u.id