-- CreateEnum
CREATE TYPE "public"."StatutVille" AS ENUM ('ACTIVE', 'INACTIVE');

-- AlterTable
ALTER TABLE "public"."Utilisateur" ADD COLUMN     "villeId" TEXT;

-- CreateTable
CREATE TABLE "public"."Ville" (
    "id" TEXT NOT NULL,
    "nom" TEXT NOT NULL,
    "statut" "public"."StatutVille" NOT NULL DEFAULT 'ACTIVE',
    "dateCreation" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "dateModification" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Ville_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Ville_nom_key" ON "public"."Ville"("nom");

-- AddForeignKey
ALTER TABLE "public"."Utilisateur" ADD CONSTRAINT "Utilisateur_villeId_fkey" FOREIGN KEY ("villeId") REFERENCES "public"."Ville"("id") ON DELETE SET NULL ON UPDATE CASCADE;
