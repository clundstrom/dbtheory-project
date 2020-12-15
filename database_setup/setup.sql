DROP DATABASE IF EXISTS general;
CREATE DATABASE IF NOT EXISTS general;
USE general;

CREATE TABLE IF NOT EXISTS `users` (
    `id` int(10) NOT NULL  AUTO_INCREMENT,
    `name` varchar(50) DEFAULT NULL,
    `hash` varchar(128) DEFAULT NULL,
    `address` varchar(82) DEFAULT NULL,
    `phone_number` varchar(82) DEFAULT NULL,
    `token` varchar(128) DEFAULT NULL,
    `fk_community_ids` varchar(20) DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE (`name`),
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

INSERT INTO `users` (`name`, `fk_community_ids`) VALUES("LuRRE", "[1,2]");
INSERT INTO `users` (`name`, `fk_community_ids`) VALUES("Ditch", "[1,2]");
INSERT INTO `users` (`name`, `fk_community_ids`) VALUES("Bob", "[3]");
INSERT INTO `users` (`name`, `fk_community_ids`) VALUES("Preben", "[]");

INSERT INTO `community` (`name`, `area`, `fk_owner_id`) VALUES("Lurres hammerdrills", "Stockholm", 1);
INSERT INTO `community` (`name`, `area`, `fk_owner_id`) VALUES("Ditch's lawnmowers", "Kalmar", 2);
INSERT INTO `community` (`name`, `area`, `fk_owner_id`) VALUES("Bobs borrowing burrow", "Göteborg",3);
INSERT INTO `community` (`name`, `area`, `fk_owner_id`) VALUES("Admin", "Jönköping", 4);

INSERT INTO `products` (`name`, `description`, `count`, `available`, `fk_community_id`) VALUES("Bosch 2k 400W", "Finest slagborrmachine on the market", 1, true, 1)