create table if not exists users(
user_id int unsigned not null auto_increment,
first_name varchar(255) not null default '',
last_name varchar(255) not null default '',
registerby enum('email','facebook_url') not null,
email_id int default null,
facebook_url varchar(255) default null,
user_rank enum('grover','') not null default '',
age_bracket enum('10-15','16-24','25-34','35-41','42-50','50-60','60+','') not null default '',
trait_conscientiousness tinyint unsigned default null, 
trait_agreeableness tinyint unsigned default null,
trait_neuroticism tinyint unsigned default null,
trait_openness tinyint unsigned default null,
trait_extraversion tinyint unsigned default null,
created_at TIMESTAMP not null DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP not null DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
primary key(user_id)
)engine = innodb;

create table if not exists user_summary(
user_id int unsigned not null,
last_login datetime default null,
total_supporters int unsigned default 0,
total_supported int unsigned default 0,
updated_at TIMESTAMP not null DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
primary key (user_id)
)engine = innodb;

create table if not exists auth(
user_id int unsigned not null,
email varchar(255) DEFAULT NULL comment "encrypted with salt",
password varchar(255) DEFAULT NULL comment "encrypted with salt",
created_at TIMESTAMP not null DEFAULT CURRENT_TIMESTAMP,
primary key(user_id),
KEY idx_email(email)
)engine = innodb comment 'a place to store and encrypt authentication details';

create table if not exists logins(
user_id int unsigned not null,
login_message enum('successful_login','session_timeout','failed_login','') not null default '',
ip_address INT(4) UNSIGNED NOT NULL comment 'use INET_ATON("127.0.0.1")',
device varchar(255) DEFAULT NULL,
created_at TIMESTAMP(3) not null DEFAULT CURRENT_TIMESTAMP(3),
primary key (user_id,created_at)
)engine = innodb comment 'history of logins';

create table if not exists meditations(
meditation_id int unsigned not null auto_increment,
message varchar(512) not null default '',
created_at TIMESTAMP not null DEFAULT CURRENT_TIMESTAMP,
primary key(meditation_id)
)engine = innodb comment 'keep a list of all the meditations of the day';

create table if not exists meditation_log(
user_id int unsigned not null,
meditation_id int unsigned not null, 
created_at  TIMESTAMP not null DEFAULT CURRENT_TIMESTAMP,
primary key(user_id,meditation_id),
KEY idx_created(created_at)
)engine = innodb comment 'to keep track which meditation the user has already seen';

create table if not exists supporters(
supporting_user_id int unsigned not null,
supporter_user_id int unsigned not null,
created_at TIMESTAMP not null DEFAULT CURRENT_TIMESTAMP,
primary key (supporting_user_id,supporter_user_id),
key idx_supporter(supporter_user_id)
)engine = innodb comment 'keep the link between supporters and supported';

create table if not exists groove_list(
groove varchar(255) not NULL
)engine = innodb comment 'a list of all premade grooves';

create table if not exists grooves(
groove_id int unsigned not null auto_increment,
user_id int unsigned not null,
description  varchar(255) not NULL,
start_time time default null,
end_time time default null,
days_of_week enum('1','2','3','4','5','6','7'),
created_at TIMESTAMP not null DEFAULT CURRENT_TIMESTAMP,
primary key (groove_id),
KEY idx_user(user_id)
)engine = innodb ;

create table if not exists groove_log(
groove_id int unsigned not null,
user_id int unsigned not null,
status enum('done','not_done') not null,
comment varchar(255) default NULL,
created_at TIMESTAMP not null DEFAULT CURRENT_TIMESTAMP,
KEY idx_user_groove(user_id,groove_id),
KEY idx_created(created_at)
)engine = innodb;

create table if not exists groove_log_archive(
groove_id int unsigned not null,
user_id int unsigned not null,
status enum('done','not_done') not null,
comment varchar(255) default NULL,
created_at TIMESTAMP not null DEFAULT CURRENT_TIMESTAMP,
KEY idx_user_groove(user_id,groove_id),
KEY idx_created(created_at)
)engine = innodb comment 'groove log entries older than 30 days need to be moved here';

create table if not exists vision_list(
vision varchar(512) not NULL
)engine = innodb comment 'a premade list of visions';

create table if not exists goal_list(
description varchar(512) not NULL
)engine = innodb comment 'a premade list of goals';

create table if not exists visions(
vision_id int unsigned not null auto_increment,
user_id int unsigned not null,
status enum('done','not_done','') not null default '',
description varchar(255) default NULL,
created_at TIMESTAMP not null DEFAULT CURRENT_TIMESTAMP,
completed_at datetime default null,
primary key (vision_id),
KEY idx_user(user_id)
)engine = innodb;

create table if not exists goals(
goal_id int unsigned not null auto_increment,
vision_id int unsigned not null,
user_id int unsigned not null,
status enum('done','not_done','') not null default '',
description varchar(255) default NULL,
created_at TIMESTAMP not null DEFAULT CURRENT_TIMESTAMP,
completed_at datetime default null,
primary key (goal_id),
KEY idx_user(user_id)
)engine = innodb;

create table if not exists tasks(
task_id int unsigned not null auto_increment,
goal_id int unsigned not null,
vision_id int unsigned not null,
user_id int unsigned not null,
status enum('done','not_done','') not null default '',
description varchar(255) default NULL,
comment varchar(255) default NULL,
created_at TIMESTAMP not null DEFAULT CURRENT_TIMESTAMP,
completed_at datetime default null,
primary key (task_id),
KEY idx_user(user_id),
KEY idx_goal(goal_id)
)engine = innodb;

create table if not exists tasks_archive(
task_id int unsigned not null,
goal_id int unsigned not null,
vision_id int unsigned not null,
user_id int unsigned not null,
status enum('done','not_done','') not null default '',
description varchar(255) default NULL,
comment varchar(255) default NULL,
created_at TIMESTAMP not null DEFAULT CURRENT_TIMESTAMP,
completed_at datetime default null,
primary key (task_id),
KEY idx_user(user_id),
KEY idx_goal(goal_id)
)engine = innodb comment 'move tasks older than 30 days into archive table';

create table if not exists journals(
user_id int unsigned not null,
note varchar(512) default NULL,
created_at TIMESTAMP not null DEFAULT CURRENT_TIMESTAMP,
KEY idx_user_date(user_id,created_at)
)engine = innodb;

create table if not exists moods(
user_id int unsigned not null,
mood_type enum('happy', 'sad','effervescent','') not null default '',
mood_amount tinyint unsigned not null default 0,
created_at TIMESTAMP not null DEFAULT CURRENT_TIMESTAMP,
KEY idx_user_date(user_id,created_at)
)engine = innodb;

create table if not exists questions(
question_id int unsigned not null auto_increment,
description varchar(512) default NULL,
trait enum('conscientiousness', 'agreeableness', 'neuroticism', 'openness','extraversion') not null,
created_at TIMESTAMP not null DEFAULT CURRENT_TIMESTAMP,
primary key (question_id)
)engine = innodb;

create table if not exists question_log(
user_id int unsigned not null,
question_id int unsigned not null,
score tinyint unsigned not null default 0,
created_at TIMESTAMP not null DEFAULT CURRENT_TIMESTAMP,
KEY idx_user_date(user_id,question_id,created_at)
)engine = innodb;

create table if not exists messages(
from_user_id int unsigned not null,
to_user_id int unsigned not null,
message varchar(512) default NULL,
created_at TIMESTAMP not null DEFAULT CURRENT_TIMESTAMP,
KEY idx_to_date(to_user_id,created_at),
KEY idx_from_to(from_user_id,to_user_id)
)engine = innodb;

create table if not exists feed(
user_id int unsigned not null,
feed_type enum('groove','goal') not null, 
groove_id int unsigned not null,
goal_id int unsigned not null,
short_description varchar(128) default NULL,
created_at TIMESTAMP not null DEFAULT CURRENT_TIMESTAMP,
KEY idx_user_date(user_id,created_at)
)engine = innodb;

create table if not exists feed_archive(
user_id int unsigned not null,
feed_type enum('groove','goal') not null, 
groove_id int unsigned not null,
goal_id int unsigned not null,
short_description varchar(128) default NULL,
created_at TIMESTAMP not null DEFAULT CURRENT_TIMESTAMP,
KEY idx_user_date(user_id,created_at)
)engine = innodb comment'feeds older than 30 days should be moved here';
