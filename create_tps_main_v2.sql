--       create database     --

create database if not exists `tps_main` /*!40100 DEFAULT CHARACTER SET latin1 */;
use tps_main;
create table if not exists user (
	user_id int primary key,
    username varchar(255) not null unique,
    password varchar(255) not null
);

create table if not exists role (
	role_id int primary key,
    role_name varchar(255) not null
);


create table if not exists service (
	service_id int primary key auto_increment,
    service_name varchar(255) not null
);


create table if not exists user_roles_service(
	user_roles_service_id int primary key auto_increment,
	user_id int not null,
    role_id int not null,
    service_id int not null,
    have_role_approval int not null,
    unique key(user_id, role_id, service_id),
    foreign key(user_id) references user(user_id),
    foreign key(role_id) references role(role_id),
    foreign key(service_id) references service(service_id)
);

-- create table users_approval
create table if not exists users_approval(
id  int primary key auto_increment,
user_approval_id int not null,
user_approval_name varchar(255) not null,
service_name varchar(255) not null,
user_id int not null,
foreign key (user_id) references user(user_id));

create table if not exists api_endpoint(
	api_endpoint_id int primary key auto_increment,
    endpoint varchar(255) not null unique,
    description varchar(255)
);

create table if not exists role_apis(
	role_apis_id int primary key auto_increment,
    role_id int not null,
    api_endpoint_id int not null,
    unique key(role_id, api_endpoint_id),
	foreign key(role_id) references role(role_id),
    foreign key(api_endpoint_id) references api_endpoint(api_endpoint_id)
);

-- create table request_form
create table if not exists request_form (
	form_id int primary key auto_increment,
    name_people_request varchar(255) not null,
    name_people_approval varchar(255) not null,
    phones_need_trace varchar(20000) not null,
    date_create_request bigint(20) not null,
    time_start_trace bigint(20) not null,
    time_end_trace bigint(20) not null,
    time_start_approval bigint(20) not null,
    time_end_approval bigint(20) not null,
    reason varchar(255),
    status int,
    domain varchar(255),
    user_id int,
    CONSTRAINT fk_user_id
    foreign key (user_id) references user(user_id)
);

create table if not exists log_request_form (
log_id int primary key auto_increment,
form_id int not null,
status int not null,
time bigint(20),
constraint fk_form_id
foreign key (form_id) references request_form(form_id)
);
 create table if not exists user_register(
 user_register_id int primary key auto_increment,
 username varchar(255) not null,
 password varchar(255) not null,
 service varchar(255) not null,
 unique key(username, service)
 );

 -- tao index cho cac bang
 create unique index usernameid on user(username) using BTREE;
 create unique index rolenameid on role(role_name) using BTREE;
 create unique index servicenameid on service(service_name) using BTREE;
 create unique index endpointid on api_endpoint(endpoint) using BTREE;
 create unique index requestformid on request_form(domain, time_start_trace, time_end_trace, name_people_request);
 create unique index usersapprovalid on users_approval(user_id);

--                  insert data        --

insert into user values(1,'admin', 'admin');
insert into user values(2,'hungnd61', 'hungnd61');
insert into user values(3,'thinhvn', 'thinhvn');
insert into user values(4,'kientd6', 'kientd6');
insert into user values(5,'trangnt195', 'trangnt195');
insert into user values(6,'hieunt92', 'hieunt92');
insert into user values(7,'minhut', 'minhut');
insert into user values(8,'quinv', 'quinv');
insert into user values(9,'quanhv', 'quanhv');
insert into user values(10,'thangtd', 'thangtd');
insert into user values(11,'longdt1', 'longdt1');
insert into user values(12,'huytt9', 'huytt9');
insert into user values(13,'trinhvt', 'trinhvt');
insert into user values(14,'thucdx', 'thucdx');


insert into role values(1, 'ADMIN_SYSTEM');
insert into role values(2, 'ADMIN_SERVICE');
insert into role values(3, 'USER');
insert into role values(4, 'AUDITOR');


insert into service values(1, 'tps');
insert into service values(2, 'geolocation');
insert into service values(3, 'datamon');
insert into service values(4, 'nims');
insert into service values(5, 'npms');

insert into user_roles_service values (1, 1, 1, 1, 1);


insert into api_endpoint (endpoint, description) values ('/admin/getAllNewUsers', 'admin getAllNewUsers');
insert into api_endpoint (endpoint, description) values ('/admin/getUsers', 'admin getUsers');
insert into api_endpoint (endpoint, description) values ('/admin/getAllUserInService/{nameService}', 'admin getAllUserInService');
insert into api_endpoint (endpoint, description) values ('/admin/editRoles', 'admin editRoles');
insert into api_endpoint (endpoint, description) values ('/admin/addRoles', 'admin addRoles');
insert into api_endpoint (endpoint, description) values ('/admin/removeRoles', 'admin removeRoles');

insert into api_endpoint (endpoint, description) values ('/admin/service/list', 'admin getServices');
insert into api_endpoint (endpoint, description) values ('/admin/service/edit', 'admin editServices');
insert into api_endpoint (endpoint, description) values ('/admin/service/add', 'admin addService');
insert into api_endpoint (endpoint, description) values ('/admin/service/remove', 'admin removeService');

insert into api_endpoint (endpoint, description) values ('/admin/apis/list', 'admin list endpoints');
insert into api_endpoint (endpoint, description) values ('/admin/apis/edit', 'admin edit endpoints');
insert into api_endpoint (endpoint, description) values ('/admin/apis/add', 'admin add endpoint');
insert into api_endpoint (endpoint, description) values ('/admin/apis/remove', 'admin remove endpoint');

insert into api_endpoint (endpoint, description) values ('/admin/editUsersApproval', 'admin editUsersApproval');
insert into api_endpoint (endpoint, description) values ('/admin/addUsersApproval', 'admin addUsersApproval');
insert into api_endpoint (endpoint, description) values ('/admin/removeUsersApproval', 'admin removeUsersApproval');


insert into api_endpoint (endpoint, description) values ('/user/login', 'user login');
insert into api_endpoint (endpoint, description) values ('/user/logout', 'user logout');
insert into api_endpoint (endpoint, description) values ('/user/register', 'user register');

insert into api_endpoint (endpoint, description) values ('/user/createRequestForm', 'user createRequestForm');
insert into api_endpoint (endpoint, description) values ('/user/appovalRequestForm', 'user appovalRequestForm');
insert into api_endpoint (endpoint, description) values ('/user/getAllRequestForm/{username}', 'user getAllRequestForm');
insert into api_endpoint (endpoint, description) values ('/user/getAllFormNeedEvaluate/{username}', 'user getAllFormNeedEvaluate');
insert into api_endpoint (endpoint, description) values ('/user/getUsersApproval', 'user getUsersApproval');

insert into api_endpoint (endpoint, description) values ('/admin/usersService/list', 'admin get all user in service');

insert into api_endpoint (endpoint, description) values ('/user/auditor/requestForm/list/{service}', 'auditor get all form in service');
insert into api_endpoint (endpoint, description) values ('/user/auditor/requestForm/list/{service}/rejected', 'auditor get all form in service');
insert into api_endpoint (endpoint, description) values ('/user/auditor/requestForm/list/{service}/accepted', 'auditor get all form in service');
insert into api_endpoint (endpoint, description) values ('/user/auditor/requestForm/list/{service}/pending', 'auditor get all form in service');


-- chuc nang cua admin system
insert into role_apis(role_id, api_endpoint_id) values (1, 1);
insert into role_apis(role_id, api_endpoint_id) values (1, 2);
insert into role_apis(role_id, api_endpoint_id) values (1, 3);
insert into role_apis(role_id, api_endpoint_id) values (1, 4);
insert into role_apis(role_id, api_endpoint_id) values (1, 5);
insert into role_apis(role_id, api_endpoint_id) values (1, 6);
insert into role_apis(role_id, api_endpoint_id) values (1, 7);
insert into role_apis(role_id, api_endpoint_id) values (1, 8);
insert into role_apis(role_id, api_endpoint_id) values (1, 9);
insert into role_apis(role_id, api_endpoint_id) values (1, 10);
insert into role_apis(role_id, api_endpoint_id) values (1, 11);
insert into role_apis(role_id, api_endpoint_id) values (1, 12);
insert into role_apis(role_id, api_endpoint_id) values (1, 13);
insert into role_apis(role_id, api_endpoint_id) values (1, 14);

insert into role_apis(role_id, api_endpoint_id) values (1, 21);
insert into role_apis(role_id, api_endpoint_id) values (1, 22);
insert into role_apis(role_id, api_endpoint_id) values (1, 23);
insert into role_apis(role_id, api_endpoint_id) values (1, 24);
insert into role_apis(role_id, api_endpoint_id) values (1, 25);

-- chuc nang cua admin service
insert into role_apis(role_id, api_endpoint_id) values (2, 3);
insert into role_apis(role_id, api_endpoint_id) values (2, 15);
insert into role_apis(role_id, api_endpoint_id) values (2, 16);
insert into role_apis(role_id, api_endpoint_id) values (2, 17);
insert into role_apis(role_id, api_endpoint_id) values (2, 21);
insert into role_apis(role_id, api_endpoint_id) values (2, 22);
insert into role_apis(role_id, api_endpoint_id) values (2, 23);
insert into role_apis(role_id, api_endpoint_id) values (2, 24);
insert into role_apis(role_id, api_endpoint_id) values (2, 25);
insert into role_apis(role_id, api_endpoint_id) values (2, 26);

-- chuc nang cua nguoi dung pho thong

insert into role_apis(role_id, api_endpoint_id) values (3, 21);
insert into role_apis(role_id, api_endpoint_id) values (3, 22);
insert into role_apis(role_id, api_endpoint_id) values (3, 23);
insert into role_apis(role_id, api_endpoint_id) values (3, 24);
insert into role_apis(role_id, api_endpoint_id) values (3, 25);

-- chuc nang cua auditor
insert into role_apis(role_id, api_endpoint_id) values (4, 27);
insert into role_apis(role_id, api_endpoint_id) values (4, 28);
insert into role_apis(role_id, api_endpoint_id) values (4, 29);
insert into role_apis(role_id, api_endpoint_id) values (4, 30);
insert into role_apis(role_id, api_endpoint_id) values (4, 21);
insert into role_apis(role_id, api_endpoint_id) values (4, 23);


