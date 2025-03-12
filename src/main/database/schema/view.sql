CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `dev01`@`%` 
    SQL SECURITY DEFINER
VIEW `recruitments` AS
    SELECT 
        `b`.`id` AS `id`,
        `a`.`name` AS `name`,
        `a`.`contact` AS `contact`,
        `a`.`email` AS `email`,
        `a`.`website` AS `website`,
        `a`.`address` AS `address`,
        `a`.`industry` AS `industry`,
        `b`.`title` AS `title`,
        `b`.`description` AS `description`,
        `b`.`end_date` AS `end_date`,
        `b`.`updated_at` AS `updated_at`
    FROM
        (`recruitment` `b`
        LEFT JOIN `company` `a` ON ((`a`.`id` = `b`.`company_id`)))
    ORDER BY `b`.`updated_at` DESC;

CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `dev01`@`%` 
    SQL SECURITY DEFINER
VIEW `representation_resume` AS
    SELECT 
        `a`.`id` AS `resume_id`,
        `a`.`user_id` AS `user_id`,
        `a`.`title` AS `resume_title`,
        `b`.`name` AS `user_name`,
        `b`.`email` AS `user_email`,
        `c`.`school_type` AS `school_type`,
        `c`.`status` AS `school_status`,
        `d`.`job_title` AS `industry`,
        `d`.`dept` AS `dept`,
        `d`.`position` AS `position`,
        `d`.`status` AS `company_status`
    FROM
        (((`resume` `a`
        JOIN `user` `b` ON ((`a`.`id` = `b`.`default_resume_id`)))
        LEFT JOIN `education` `c` ON ((`a`.`id` = `c`.`resume_id`)))
        LEFT JOIN `experience` `d` ON ((`a`.`id` = `d`.`resume_id`)));

CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `dev01`@`%` 
    SQL SECURITY DEFINER
VIEW `scrap_view` AS
    SELECT 
        `s`.`id` AS `id`,
        `u`.`id` AS `user_id`,
        `r`.`id` AS `recruitment_id`,
        `s`.`scrap_at` AS `scrap_at`,
        `c`.`name` AS `corp_name`,
        `r`.`title` AS `recr_title`,
        `r`.`end_date` AS `end_date`
    FROM
        (((`scrap` `s`
        JOIN `user` `u`)
        JOIN `recruitment` `r`)
        JOIN `company` `c`)
    WHERE
        ((`s`.`user_id` = `u`.`id`)
            AND (`s`.`recruitment_id` = `r`.`id`)
            AND (`r`.`company_id` = `c`.`id`));
