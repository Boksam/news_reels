-- CreateTable
CREATE TABLE `Article` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `headline` VARCHAR(191) NULL,
    `content` LONGTEXT NULL,
    `full_summary` LONGTEXT NULL,
    `one_line_summary` TEXT NULL,
    `section` VARCHAR(191) NULL,
    `type` VARCHAR(191) NULL,
    `thumbnail` VARCHAR(191) NULL,
    `language` VARCHAR(191) NULL,
    `url` VARCHAR(191) NOT NULL,
    `created_at` DATETIME(3) NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NULL DEFAULT CURRENT_TIMESTAMP(3),

    UNIQUE INDEX `Article_url_key`(`url`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
