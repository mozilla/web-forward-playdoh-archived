ALTER TABLE `apply_application` ADD (
    `program_selection` varchar(50) NOT NULL,
    `benefit` longtext NOT NULL,
    `want_designer` tinyint DEFAULT 0 NOT NULL
);
