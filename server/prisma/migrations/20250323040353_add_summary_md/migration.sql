/*
  Warnings:

  - You are about to drop the column `full_summary` on the `Article` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE `Article` DROP COLUMN `full_summary`,
    ADD COLUMN `summary_md` LONGTEXT NULL;
