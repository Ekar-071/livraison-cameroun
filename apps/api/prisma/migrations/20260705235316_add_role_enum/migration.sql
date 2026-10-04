/*
  Warnings:

  - The `role` column on the `Utilisateur` table would be dropped and recreated. This will lead to data loss if there is data in the column.

*/
-- CreateEnum
CREATE TYPE "public"."Role" AS ENUM ('CLIENT', 'ADMIN');

-- AlterTable
ALTER TABLE "public"."Utilisateur" DROP COLUMN "role",
ADD COLUMN     "role" "public"."Role" NOT NULL DEFAULT 'CLIENT';
