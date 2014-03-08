DROP TABLE IF EXISTS user;


CREATE TABLE user
(userID INT auto_increment primary key,
username varchar(50),
email varchar(100) UNIQUE key,
 passHash varchar(256));

#INSERT INTO user (username, email, passHash)
#VALUES ("Bob", "dumb@loveSpinach.com","sadfasdfhaskdfhasdf");



DROP TABLE IF EXISTS site;

CREATE TABLE site (
siteID INT auto_increment primary key,
domainName varchar(150)
);

DROP TABLE IF EXISTS owns;

CREATE TABLE owns (
userId INT,
siteId INT
);

#SELECT * FROM user;


##SELECT passHash FROM User WHERE email = "dumb@loveSpinach.com";