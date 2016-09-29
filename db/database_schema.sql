PRAGMA foreign_keys = true;
CREATE TABLE Category (
	id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
	subject VARCHAR(255) NOT NULL,
	upper_category_id UNSIGNED INTEGER,
	FOREIGN KEY(upper_category_id) REFERENCES Category(id)
);

CREATE TABLE Discussion (
	id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
	title VARCHAR(255) NOT NULL,
	category_id UNSIGNED INTEGER NOT NULL,
	FOREIGN KEY(category_id) REFERENCES Category(id)
);

CREATE TABLE Message (
	id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
	user_id VARCHAR(255) NOT NULL,
	message TEXT NOT NULL,
	time TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
	last_edited TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
	discussion_id UNSIGNED INTEGER NOT NULL,
	FOREIGN KEY(discussion_id) REFERENCES Discussion(id)
	FOREIGN KEY(user_id) REFERENCES User(id)
);

CREATE TABLE User (
	id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
	nick VARCHAR(255) UNIQUE NOT NULL,
	password VARCHAR(255) NOT NULL,
	salt VARCHAR(255) NOT NULL,
	created TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
	admin boolean DEFAULT False NOT NULL,
	last_login TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

INSERT INTO User (nick, password, salt) VALUES ('pena02', '$2a$10$XmwRP.myrViIQRTDzDkepesHPuV6QK2tNfjcW9vMnfCluCZMWZJOq', '$2a$10$6JbdF6KM9tTNDmxM391OMO');
INSERT INTO User (nick, password, salt) VALUES ('tero1', '$2a$10$eczohRcGISxD3sr09TS65OXjRD8maTnXUxX.zMVGCNzzxNm97Roi2', '2a$10$eczohRcGISxD3sr09TS65O');
INSERT INTO User (nick, password, salt) VALUES ('kirjottelija007', '$2a$10$hpZudutAUDfdIie/iIm8JOlcDLW0Q6oq3mDrd2y9/ds9goC60Kip6', '$2a$10$hpZudutAUDfdIie/iIm8JO');

INSERT INTO Category (subject) VALUES ('Autot');
INSERT INTO Category (subject) VALUES ('Lehmät');
INSERT INTO Category (subject) VALUES ('Kissat');
INSERT INTO Category (subject) VALUES ('Tietokoneet');

INSERT INTO Discussion (title, category_id) VALUES ('Mun lempiauto', 1);
INSERT INTO Discussion (title, category_id) VALUES ('Mersut > Audit', 1);
INSERT INTO Discussion (title, category_id) VALUES ('Miks hevonen maistuu paremmalta kun lehmä?', 2);
INSERT INTO Discussion (title, category_id) VALUES ('Kissa putosi ikkunasta, pitäiskö huolestua?', 3);
INSERT INTO Discussion (title, category_id) VALUES ('Linux vai Commodore64?', 4);
INSERT INTO Discussion (title, category_id) VALUES ('Postaa ATARI-setupistas kuvia!', 4);

INSERT INTO Message (user_id, message, discussion_id) VALUES (1, "Lada on paras helposti, mitä mieltä muut?", 1);
INSERT INTO Message (user_id, message, discussion_id) VALUES (2, "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", 2);
INSERT INTO Message (user_id, message, discussion_id) VALUES (3, "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", 2);
INSERT INTO Message (user_id, message, discussion_id) VALUES (2, "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", 3);
INSERT INTO Message (user_id, message, discussion_id) VALUES (2, "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", 4);
INSERT INTO Message (user_id, message, discussion_id) VALUES (1, "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", 5);
INSERT INTO Message (user_id, message, discussion_id) VALUES (3, "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", 6);
INSERT INTO Message (user_id, message, discussion_id) VALUES (1, "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", 3);
