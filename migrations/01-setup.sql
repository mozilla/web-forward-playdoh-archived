DROP TABLE IF EXISTS `apply_application`;

CREATE TABLE `apply_application` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `email` varchar(75) NOT NULL,
  `phone_number` varchar(30) NOT NULL,
  `teammates` longtext NOT NULL,
  `video_url` varchar(200) NOT NULL,
  `pitch` longtext NOT NULL,
  `interest` varchar(50) NOT NULL,
  `team_info` longtext NOT NULL,
  `team_accomplishments` longtext NOT NULL,
  `team_history` longtext NOT NULL,
  `reason_for_idea` longtext NOT NULL,
  `uniqueness_of_idea` longtext NOT NULL,
  `idea_relevance` longtext NOT NULL,
  `why_mozilla` longtext NOT NULL,
  `progress` longtext NOT NULL,
  `launch_info` longtext NOT NULL,
  `demo_url` varchar(200) NOT NULL,
  `team_exclusive_members` longtext NOT NULL,
  `team_non_exclusive_members` longtext NOT NULL,
  `team_prior_commitments` longtext NOT NULL,
  `location` longtext NOT NULL,
  `legal` longtext NOT NULL,
  `source_code_info` longtext NOT NULL,
  `anecdote` longtext NOT NULL,
  `other` longtext NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `auth_group`;

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `auth_group_permissions`;

CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `group_id` (`group_id`,`permission_id`),
  KEY `auth_group_permissions_bda51c3c` (`group_id`),
  KEY `auth_group_permissions_1e014c8f` (`permission_id`),
  CONSTRAINT `group_id_refs_id_3cea63fe` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `permission_id_refs_id_a7792de1` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `auth_message`;

CREATE TABLE `auth_message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `message` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `auth_message_fbfc09f1` (`user_id`),
  CONSTRAINT `user_id_refs_id_9af0b65a` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `auth_permission`;

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `content_type_id` (`content_type_id`,`codename`),
  KEY `auth_permission_e4470c6e` (`content_type_id`),
  CONSTRAINT `content_type_id_refs_id_728de91f` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8;

INSERT INTO `auth_permission` (`id`,`name`,`content_type_id`,`codename`)
VALUES
	(1,'Can add application',1,'add_application'),
	(2,'Can change application',1,'change_application'),
	(3,'Can delete application',1,'delete_application'),
	(4,'Can add task meta',2,'add_taskmeta'),
	(5,'Can change task meta',2,'change_taskmeta'),
	(6,'Can delete task meta',2,'delete_taskmeta'),
	(7,'Can add taskset meta',3,'add_tasksetmeta'),
	(8,'Can change taskset meta',3,'change_tasksetmeta'),
	(9,'Can delete taskset meta',3,'delete_tasksetmeta'),
	(10,'Can add interval',4,'add_intervalschedule'),
	(11,'Can change interval',4,'change_intervalschedule'),
	(12,'Can delete interval',4,'delete_intervalschedule'),
	(13,'Can add crontab',5,'add_crontabschedule'),
	(14,'Can change crontab',5,'change_crontabschedule'),
	(15,'Can delete crontab',5,'delete_crontabschedule'),
	(16,'Can add periodic tasks',6,'add_periodictasks'),
	(17,'Can change periodic tasks',6,'change_periodictasks'),
	(18,'Can delete periodic tasks',6,'delete_periodictasks'),
	(19,'Can add periodic task',7,'add_periodictask'),
	(20,'Can change periodic task',7,'change_periodictask'),
	(21,'Can delete periodic task',7,'delete_periodictask'),
	(22,'Can add worker',8,'add_workerstate'),
	(23,'Can change worker',8,'change_workerstate'),
	(24,'Can delete worker',8,'delete_workerstate'),
	(25,'Can add task',9,'add_taskstate'),
	(26,'Can change task',9,'change_taskstate'),
	(27,'Can delete task',9,'delete_taskstate'),
	(28,'Can add permission',10,'add_permission'),
	(29,'Can change permission',10,'change_permission'),
	(30,'Can delete permission',10,'delete_permission'),
	(31,'Can add group',11,'add_group'),
	(32,'Can change group',11,'change_group'),
	(33,'Can delete group',11,'delete_group'),
	(34,'Can add user',12,'add_user'),
	(35,'Can change user',12,'change_user'),
	(36,'Can delete user',12,'delete_user'),
	(37,'Can add message',13,'add_message'),
	(38,'Can change message',13,'change_message'),
	(39,'Can delete message',13,'delete_message'),
	(40,'Can add content type',14,'add_contenttype'),
	(41,'Can change content type',14,'change_contenttype'),
	(42,'Can delete content type',14,'delete_contenttype'),
	(43,'Can add session',15,'add_session'),
	(44,'Can change session',15,'change_session'),
	(45,'Can delete session',15,'delete_session'),
	(46,'Can add log entry',16,'add_logentry'),
	(47,'Can change log entry',16,'change_logentry'),
	(48,'Can delete log entry',16,'delete_logentry');

DROP TABLE IF EXISTS `auth_user`;

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(30) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(75) NOT NULL,
  `password` varchar(255) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `last_login` datetime NOT NULL,
  `date_joined` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `auth_user_groups`;

CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`group_id`),
  KEY `auth_user_groups_fbfc09f1` (`user_id`),
  KEY `auth_user_groups_bda51c3c` (`group_id`),
  CONSTRAINT `user_id_refs_id_831107f1` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `group_id_refs_id_f0ee9890` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `auth_user_user_permissions`;

CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`permission_id`),
  KEY `auth_user_user_permissions_fbfc09f1` (`user_id`),
  KEY `auth_user_user_permissions_1e014c8f` (`permission_id`),
  CONSTRAINT `user_id_refs_id_f2045483` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `permission_id_refs_id_67e79cb` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `django_admin_log`;

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime NOT NULL,
  `user_id` int(11) NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_fbfc09f1` (`user_id`),
  KEY `django_admin_log_e4470c6e` (`content_type_id`),
  CONSTRAINT `content_type_id_refs_id_288599e6` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `user_id_refs_id_c8665aa` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `django_content_type`;

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `app_label` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

INSERT INTO `django_content_type` (`id`,`name`,`app_label`,`model`)
VALUES
	(1,'application','apply','application'),
	(2,'task meta','djcelery','taskmeta'),
	(3,'taskset meta','djcelery','tasksetmeta'),
	(4,'interval','djcelery','intervalschedule'),
	(5,'crontab','djcelery','crontabschedule'),
	(6,'periodic tasks','djcelery','periodictasks'),
	(7,'periodic task','djcelery','periodictask'),
	(8,'worker','djcelery','workerstate'),
	(9,'task','djcelery','taskstate'),
	(10,'permission','auth','permission'),
	(11,'group','auth','group'),
	(12,'user','auth','user'),
	(13,'message','auth','message'),
	(14,'content type','contenttypes','contenttype'),
	(15,'session','sessions','session'),
	(16,'log entry','admin','logentry');

DROP TABLE IF EXISTS `django_session`;

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_c25c2c28` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `djcelery_crontabschedule`;

CREATE TABLE `djcelery_crontabschedule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `minute` varchar(64) NOT NULL,
  `hour` varchar(64) NOT NULL,
  `day_of_week` varchar(64) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `djcelery_intervalschedule`;

CREATE TABLE `djcelery_intervalschedule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `every` int(11) NOT NULL,
  `period` varchar(24) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `djcelery_periodictask`;

CREATE TABLE `djcelery_periodictask` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `task` varchar(200) NOT NULL,
  `interval_id` int(11) DEFAULT NULL,
  `crontab_id` int(11) DEFAULT NULL,
  `args` longtext NOT NULL,
  `kwargs` longtext NOT NULL,
  `queue` varchar(200) DEFAULT NULL,
  `exchange` varchar(200) DEFAULT NULL,
  `routing_key` varchar(200) DEFAULT NULL,
  `expires` datetime DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL,
  `last_run_at` datetime DEFAULT NULL,
  `total_run_count` int(10) unsigned NOT NULL,
  `date_changed` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `djcelery_periodictask_17d2d99d` (`interval_id`),
  KEY `djcelery_periodictask_7aa5fda` (`crontab_id`),
  CONSTRAINT `crontab_id_refs_id_ebff5e74` FOREIGN KEY (`crontab_id`) REFERENCES `djcelery_crontabschedule` (`id`),
  CONSTRAINT `interval_id_refs_id_f2054349` FOREIGN KEY (`interval_id`) REFERENCES `djcelery_intervalschedule` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `djcelery_periodictasks`;

CREATE TABLE `djcelery_periodictasks` (
  `ident` smallint(6) NOT NULL,
  `last_update` datetime NOT NULL,
  PRIMARY KEY (`ident`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `djcelery_taskstate`;

CREATE TABLE `djcelery_taskstate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `state` varchar(64) NOT NULL,
  `task_id` varchar(36) NOT NULL,
  `name` varchar(200) DEFAULT NULL,
  `tstamp` datetime NOT NULL,
  `args` longtext,
  `kwargs` longtext,
  `eta` datetime DEFAULT NULL,
  `expires` datetime DEFAULT NULL,
  `result` longtext,
  `traceback` longtext,
  `runtime` double DEFAULT NULL,
  `worker_id` int(11) DEFAULT NULL,
  `hidden` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `task_id` (`task_id`),
  KEY `djcelery_taskstate_52094d6e` (`name`),
  KEY `djcelery_taskstate_f0ba6500` (`tstamp`),
  KEY `djcelery_taskstate_20fc5b84` (`worker_id`),
  CONSTRAINT `worker_id_refs_id_4e3453a` FOREIGN KEY (`worker_id`) REFERENCES `djcelery_workerstate` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `djcelery_workerstate`;

CREATE TABLE `djcelery_workerstate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `hostname` varchar(255) NOT NULL,
  `last_heartbeat` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `hostname` (`hostname`),
  KEY `djcelery_workerstate_eb8ac7e4` (`last_heartbeat`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
