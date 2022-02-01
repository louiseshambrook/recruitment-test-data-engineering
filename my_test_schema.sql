create schema `my_test_schema`;

create table `my_test_schema.people`(
`given_name` varchar(80) default null,
`family_name` varchar(80) default null,
`date_of_birth` date not null, 
`place_of_birth` int not null auto_increment,
foreign key (`place_of_birth`),
);

create table `my_test_schema.places`(
`city` varchar(80) default null,
`county` varchar(80) default null,
`country` varchar(80) default null,
foreign key (`city`)
);
