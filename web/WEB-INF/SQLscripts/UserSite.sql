DROP TABLE IF EXISTS user;

CREATE TABLE user
(userID INT auto_increment primary key,
username varchar(50),
email varchar(100) UNIQUE key,
 passHash varchar(256),
accessPrivilege varchar(50)
);

DROP TABLE IF EXISTS pages;

CREATE TABLE pages (
pageId INT auto_increment primary key,
pageType varchar(50)

);


DROP TABLE IF EXISTS contributesTo;

CREATE TABLE conitributesTo (
userId INT,
pageId INT
);

DROP TABLE IF EXISTS content;

CREATE TABLE content (
contentID varchar(32),
contentType varchar(50)
);

DROP TABLE IF EXISTS usedIn;

CREATE TABLE usedIn (
contentID varchar(32),
pageId INT
);