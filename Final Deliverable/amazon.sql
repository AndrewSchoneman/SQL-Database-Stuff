
USE db_jyang23;
set foreign_key_checks=0;

drop table if exists contain;
drop table if exists pays;
drop table if exists offer;
drop table if exists makes;
drop table if exists views;
drop table if exists feedback;
DROP TABLE IF EXISTS creditcard;
drop table if exists purchase;

/*
mysql -h"dbdev.cs.uiowa.edu" -u"jyang23" -D"db_jyang23" -P"3306" -p"Ax_-Z6zQJd2D" <amazon.sql

*/


DROP TABLE IF EXISTS amazonuser;
CREATE TABLE amazonuser(
	email VARCHAR(100) NOT NULL,
	fname VARCHAR(50),
	lname VARCHAR(50),
	age INT,
	address VARCHAR(150) NOT NULL,
	PRIMARY KEY(email)
);


DROP TABLE IF EXISTS buyer;
create table buyer(
	b_ID INT NOT NULL REFERENCES amazonUser(email),
	email VARCHAR(100) NOT NULL,
	PRIMARY KEY(b_ID)
);



DROP TABLE IF EXISTS seller;
create table seller(
	s_ID INT NOT NULL REFERENCES  amazonUser(email),
	email VARCHAR(100) NOT NULL,
	PRIMARY KEY(s_ID)
);


create table purchase(
	p_ID INT NOT NULL,
	totalCost DECIMAL(19,4),
	tax DECIMAL(19,4),
	discount DECIMAL(19,4),
	s_ID int not null,
	b_id int not null,
	cnumber int not null,
	purchaseDate DATE,
	purchaseTime TIME,
	PRIMARY KEY(p_ID),
	foreign key (s_id) references seller(s_ID) on delete cascade ,
	foreign key (b_id) references buyer(b_id) on delete cascade
);




DROP TABLE IF EXISTS item;
create table item(
	item_ID INT NOT NULL,
	name VARCHAR(100),
	price DECIMAL(19,4),
  category varchar(100),
	PRIMARY KEY(item_ID)
);


create table feedback(
	f_ID INT NOT NULL,
	b_ID INT ,
	s_ID INT ,
	feedbackDate DATE,
	feedbackTime TIME,
	feedbackComment VARCHAR(1000),
	rating INT NOT NULL,
	PRIMARY KEY(f_ID),
	FOREIGN KEY(b_ID) REFERENCES buyer(b_ID) ON DELETE CASCADE ,
	FOREIGN KEY(s_ID) REFERENCES seller(s_ID) ON DELETE  CASCADE
);


create table creditcard(
	cnumber INT NOT NULL,
	b_ID INT ,
	expirationDate DATE NOT NULL,
	cvv INT NOT NULL,
	PRIMARY KEY(cnumber, b_ID)
);


create table views(
	b_Id int not null ,
	item_Id INT NOT NULL ,
	primary key (b_Id, item_Id),
	foreign key (b_Id) references buyer(b_ID) on delete cascade ,
	foreign key (item_Id) references item(item_ID) on delete cascade

);

create table offer(
	s_ID int not null,
	Item_ID int not null ,
	primary key (s_ID, Item_ID),
	foreign key (s_Id) references buyer(b_ID) on delete cascade ,
	foreign key (item_Id) references item(item_ID) on delete cascade
);


create table pays(
	cnumber INT NOT NULL,
	p_ID INT ,
	PRIMARY KEY(cnumber, p_ID),
	FOREIGN KEY(cnumber) REFERENCES creditcard(cnumber) ON DELETE CASCADE ,
	FOREIGN KEY(p_ID) REFERENCES purchase(p_ID) ON DELETE CASCADE
);

create table contain(
	item_id int not null,
	p_id int not null,
	qn int not null,
	primary key (item_id, p_Id),
	FOREIGN KEY (item_Id) references Item(item_ID) on delete cascade ,
	foreign key (p_Id) references purchase(p_ID) on delete cascade
);

INSERT INTO amazonuser(email, fname, lname, age, address) VALUES("user1@gmail.com", "Bob", "Jones", 20, "123 fake st");
INSERT INTO amazonuser(email, fname, lname, age, address) VALUES("user2@gmail.com", "Adam", "Johnson", 36, "Caribou court");
INSERT INTO amazonuser(email, fname, lname, age, address) VALUES("user3@gmail.com", "Roger", "Smith", 80, "100 Broadway Drive");
INSERT INTO amazonuser(email, fname, lname, age, address) VALUES("user4@gmail.com", "Leah", "Thompson", 44, "3802 Pasadena Avenue");
INSERT INTO amazonuser(email, fname, lname, age, address) VALUES("user5@gmail.com", "Bill", "Bonehead", 55, "Crazy Lane Drive");
INSERT INTO buyer(b_ID, email) VALUES(1, "user1@gmail.com");
INSERT INTO buyer(b_ID, email) Values(2, "user2@gmail.com");
INSERT INTO buyer(b_ID, email) VALUES(3, "user3@gmail.com");
INSERT INTO seller(s_ID, email) VALUES(1, "user4@gmail.com");
INSERT INTO seller(s_ID, email) VALUES(2, "user5@gmail.com");
INSERT INTO seller(s_ID, email) VALUES(3, "user3@gmail.com");
INSERT INTO item(item_ID, name, price,category) VALUES(1, "database systems", 238.38, "book");
INSERT INTO item(item_ID, name, price,category) VALUES(2, "super Mario", 59.99,"video game");
INSERT INTO item(item_ID, name, price,category) VALUES(3, "lenovo thinkpad", 1455.89,"electronics");
INSERT INTO item(item_ID, name, price,category) VALUES(4, "rayband", 19.99,"fashion");
INSERT INTO item(item_ID, name, price,category) VALUES(5, "usb", 7.99,"electronics");
INSERT INTO item(item_ID, name, price,category) VALUES(6, "notebook", 1.99,"school supplies");
INSERT INTO item(item_ID, name, price,category) VALUES(7, "earbuds", 14.99, "electronics");
INSERT INTO item(item_ID, name, price,category) VALUES(8, "backpack", 49.99, "school supplies");
INSERT INTO item(item_ID, name, price,category) VALUES(9, "sneakers", 99.99, "fashion");
INSERT INTO item(item_ID, name, price,category) VALUES(10, "echo dot", 49.99, "electronics");
INSERT INTO item(item_ID, name, price,category) VALUES(11, "iphone", 899.99, "electronics");
INSERT INTO item(item_ID, name, price,category) VALUES(12, "ipad", 599.99, "electronics");


INSERT INTO views(b_Id, item_Id) VALUES (1, 2);
INSERT INTO views(b_Id, item_Id) VALUES (1, 3);
INSERT INTO views(b_Id, item_Id) VALUES (1, 4);
INSERT INTO views(b_Id, item_Id) VALUES (1, 11);
INSERT INTO views(b_Id, item_Id) VALUES (2, 3);
INSERT INTO views(b_Id, item_Id) VALUES (2, 1);
INSERT INTO views(b_Id, item_Id) VALUES (2, 4);
INSERT INTO views(b_Id, item_Id) VALUES (2, 7);
INSERT INTO views(b_Id, item_Id) VALUES (2, 8);
INSERT INTO views(b_Id, item_Id) VALUES (2, 2);
INSERT INTO views(b_Id, item_Id) VALUES (3, 7);
INSERT INTO views(b_Id, item_Id) VALUES (1, 1);
INSERT INTO views(b_Id, item_Id) VALUES (3, 1);
INSERT INTO views(b_Id, item_Id) VALUES (3, 2);
INSERT INTO views(b_Id, item_Id) VALUES (1, 8);

/*lol*/
INSERT INTO offer(s_ID, Item_ID) VALUES (1,1);
INSERT INTO offer(s_ID, Item_ID) VALUES (2,2);
INSERT INTO offer(s_ID, Item_ID) VALUES (3,3);
INSERT INTO offer(s_ID, Item_ID) VALUES (3,4);
INSERT INTO offer(s_ID, Item_ID) VALUES (2,5);
INSERT INTO offer(s_ID, Item_ID) VALUES (2,6);
INSERT INTO offer(s_ID, Item_ID) VALUES (3,7);
INSERT INTO offer(s_ID, Item_ID) VALUES (1,8);
INSERT INTO offer(s_ID, Item_ID) VALUES (2,9);
INSERT INTO offer(s_ID, Item_ID) VALUES (1,10);
INSERT INTO offer(s_ID, Item_ID) VALUES (1,11);

INSERT INTO creditcard(cnumber, b_ID, expirationDate, cvv) VALUES (1111222233334444, 1, '2018-02-03', 111);
INSERT INTO creditcard(cnumber, b_ID, expirationDate, cvv) VALUES (1221312332131232, 2, '2019-06-05', 222);
INSERT INTO creditcard(cnumber, b_ID, expirationDate, cvv) VALUES (2131237218932173, 3, '2018-07-08', 333);

INSERT INTO purchase(p_ID, totalCost, tax, discount, s_ID, b_ID, purchaseDate) VALUES (1, 100, .02, 0, 1, 1, '1999-01-01');
INSERT INTO purchase(p_ID, totalCost, tax, discount, s_ID, b_ID, purchaseDate) VALUES (2, 5.55, .51, 10, 1, 2, '2017-12-10');
INSERT INTO purchase(p_ID, totalCost, tax, discount, s_ID, b_ID, purchaseDate) VALUES (3, 54.89,12.0, 0, 1, 3, '2017-12-15');
INSERT INTO purchase(p_ID, totalCost, tax, discount, s_ID, b_ID, purchaseDate) VALUES (4, 89.52, .02, 0, 2, 1, '2017-12-07');
INSERT INTO purchase(p_ID, totalCost, tax, discount, s_ID, b_ID, purchaseDate) VALUES (5, 1108.23, 15.00, 2, 1, 1, '2017-12-13');
INSERT INTO purchase(p_ID, totalCost, tax, discount, s_ID, b_ID, purchaseDate) VALUES (6, 230.25, 0, 10, 2, 3, '2015-07-13');
INSERT INTO purchase(p_ID, totalCost, tax, discount, s_ID, b_ID, purchaseDate) VALUES (7, 235.23, .02, 0, 2, 1, '2014-01-01');
INSERT INTO purchase(p_ID, totalCost, tax, discount, s_ID, b_ID, purchaseDate) VALUES (8, 1269.37, .05, 0, 3, 2, '2017-01-01');

INSERT INTO pays(cnumber, p_ID) VALUES (1111222233334444,1);
INSERT INTO pays(cnumber, p_ID) VALUES (1221312332131232,2);
INSERT INTO pays(cnumber, p_ID) VALUES (2131237218932173,3);
INSERT INTO pays(cnumber, p_ID) VALUES (1221312332131232,4);
INSERT INTO pays(cnumber, p_ID) VALUES (1111222233334444,5);
INSERT INTO pays(cnumber, p_ID) VALUES (1221312332131232,6);
INSERT INTO pays(cnumber, p_ID) VALUES (1111222233334444,7);
insert into pays(cnumber, p_ID) VALUES (2131237218932173,8);


/* feedback */
INSERT INTO feedback(f_ID, b_ID, s_ID, feedbackDate, rating,feedbackComment) VALUES (1, 1, 1, '1999-01-08 02:30:00', 4, "aldkjfal;sdjfasaf;alsf");
INSERT INTO feedback(f_ID, b_ID, s_ID, feedbackDate, rating, feedbackComment) VALUES (2, 1, 2, '2017-01-13 20:30:00', 5, "aldkjfal;sdjfasaf;alsf");
INSERT INTO feedback(f_ID, b_ID, s_ID, feedbackDate, rating, feedbackComment) VALUES (3, 1, 3, '2017-01-01 22:30:00', 2, "aldkjfal;sdjfasaf;alsf");
INSERT INTO feedback(f_ID, b_ID, s_ID, feedbackDate, rating, feedbackComment) VALUES (4, 2, 1, '2017-01-01 23:30:00', 3, "aldkjfal;sdjfasaf;alsf");
INSERT INTO feedback(f_ID, b_ID, s_ID, feedbackDate, rating, feedbackComment) VALUES (5, 3, 1, '2014-01-01 12:30:00', 1, "aldkjfal;sdjfasaf;alsf asldfj as;ld  a;sld kfa;sld f");
INSERT INTO feedback(f_ID, b_ID, s_ID, feedbackDate, rating, feedbackComment) VALUES (6, 1, 1, '2015-01-01 09:55:00', 5, "aldkjfal;sdjfasaf;alsf");

INSERT INTO contain(item_ID, p_ID, qn) VALUES (11, 1, 2);
INSERT INTO contain(item_ID, p_ID, qn) VALUES (2, 2, 5);
INSERT INTO contain(item_ID, p_ID, qn) VALUES (5, 3, 1);
INSERT INTO contain(item_ID, p_ID, qn) VALUES (6, 4, 3);
INSERT INTO contain(item_ID, p_ID, qn) VALUES (6, 5, 1);
INSERT INTO contain(item_ID, p_ID, qn) VALUES (9, 6, 6);
INSERT INTO contain(item_ID, p_ID, qn) VALUES (10, 7, 1);
INSERT INTO contain(item_ID, p_ID, qn) VALUES (1, 1, 1);
INSERT INTO contain(item_ID, p_ID, qn) VALUES (12, 8, 3);

