CREATE TABLE `apply` (
  `id` int NOT NULL AUTO_INCREMENT,
  `recruitment_id` int NOT NULL,
  `user_id` int NOT NULL,
  `resume_id` int NOT NULL,
  `status` enum('applied','interview','hired','rejected') NOT NULL DEFAULT 'applied',
  `applied_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `recruitment_id` (`recruitment_id`,`user_id`),
  KEY `fk_recruitment_user_idx` (`recruitment_id`,`user_id`) /*!80000 INVISIBLE */,
  KEY `fk_resume_idx` (`resume_id`),
  KEY `apply_ibfk_2_idx` (`user_id`),
  CONSTRAINT `apply_ibfk_1` FOREIGN KEY (`recruitment_id`) REFERENCES `recruitment` (`id`),
  CONSTRAINT `apply_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `apply_ibfk_3` FOREIGN KEY (`resume_id`) REFERENCES `resume` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `company` (
  `id` int NOT NULL AUTO_INCREMENT,
  `corpid` varchar(20) NOT NULL,
  `password` varchar(20) NOT NULL,
  `business_reg_no` varchar(20) NOT NULL,
  `image` blob,
  `name` varchar(20) NOT NULL,
  `description` mediumtext,
  `contact` varchar(20) NOT NULL,
  `email` varchar(40) NOT NULL,
  `owner` varchar(10) NOT NULL,
  `industry` varchar(20) NOT NULL,
  `est_date` date DEFAULT NULL,
  `website` varchar(50) DEFAULT NULL,
  `emp_count` int DEFAULT NULL,
  `sales` bigint DEFAULT NULL,
  `address` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `contact_UNIQUE` (`contact`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  UNIQUE KEY `name_UNIQUE` (`name`),
  UNIQUE KEY `business_reg_no_UNIQUE` (`business_reg_no`),
  UNIQUE KEY `corpid_UNIQUE` (`corpid`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `education` (
  `id` int NOT NULL AUTO_INCREMENT,
  `resume_id` int NOT NULL,
  `school_type` enum('elem','mid','high','univ') DEFAULT 'univ',
  `school_name` varchar(10) DEFAULT NULL,
  `status` enum('grad','enroll','drop') DEFAULT 'grad',
  `adm_at` date DEFAULT NULL,
  `grad_at` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk1_idx` (`resume_id`),
  CONSTRAINT `education_ibfk_1` FOREIGN KEY (`resume_id`) REFERENCES `resume` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `experience` (
  `id` int NOT NULL AUTO_INCREMENT,
  `resume_id` int NOT NULL,
  `job_title` varchar(10) DEFAULT NULL,
  `dept` varchar(10) DEFAULT NULL,
  `position` varchar(10) DEFAULT NULL,
  `prev_role` text,
  `status` enum('leave','ongoing') DEFAULT 'leave',
  `join_at` date DEFAULT NULL,
  `leave_or_ongoing_at` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk1_idx` (`resume_id`),
  CONSTRAINT `experience_ibfk_1` FOREIGN KEY (`resume_id`) REFERENCES `resume` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `job_offer` (
  `user_id` int NOT NULL,
  `company_id` int NOT NULL,
  `status` varchar(10) DEFAULT 'offered',
  `offered_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`,`company_id`),
  KEY `fk_company_id_idx` (`company_id`),
  CONSTRAINT `fk_company` FOREIGN KEY (`company_id`) REFERENCES `company` (`id`),
  CONSTRAINT `fk_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `license` (
  `id` int NOT NULL AUTO_INCREMENT,
  `resume_id` int NOT NULL,
  `value` varchar(10) NOT NULL,
  `issued_at` date NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk1` (`resume_id`,`value`),
  KEY `fk1_idx` (`resume_id`),
  CONSTRAINT `license_ibfk_1` FOREIGN KEY (`resume_id`) REFERENCES `resume` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `recruitment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `company_id` int NOT NULL,
  `status` enum('active','expired') NOT NULL DEFAULT 'active',
  `title` varchar(30) NOT NULL DEFAULT 'default title',
  `description` mediumtext NOT NULL,
  `content` mediumblob,
  `salary` int DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `school_type` enum('elem','mid','high','univ') DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_company_id_idx` (`company_id`),
  CONSTRAINT `fk_company_id` FOREIGN KEY (`company_id`) REFERENCES `company` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='직급/직책\n근무일시/요일';

CREATE TABLE `resume` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `portrait` blob,
  `title` varchar(30) NOT NULL DEFAULT '제목 없음',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_user_id_idx` (`user_id`),
  CONSTRAINT `fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `scrap` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `recruitment_id` int NOT NULL,
  `scrap_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk1` (`user_id`,`recruitment_id`) /*!80000 INVISIBLE */,
  KEY `fk1_idx` (`user_id`),
  KEY `fk2_idx` (`recruitment_id`),
  CONSTRAINT `scrap_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `scrap_ibfk_2` FOREIGN KEY (`recruitment_id`) REFERENCES `recruitment` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `default_resume_id` int DEFAULT NULL,
  `username` varchar(20) NOT NULL,
  `password` varchar(20) NOT NULL,
  `name` varchar(10) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `email` varchar(40) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `phone_UNIQUE` (`phone`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  UNIQUE KEY `userid_UNIQUE` (`username`),
  KEY `fk_resume_idx` (`default_resume_id`),
  CONSTRAINT `fk_resume` FOREIGN KEY (`default_resume_id`) REFERENCES `resume` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
