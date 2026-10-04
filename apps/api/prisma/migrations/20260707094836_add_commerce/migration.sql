-- CreateTable
CREATE TABLE "public"."Commerce" (
    "id" TEXT NOT NULL,
    "nom" TEXT NOT NULL,
    "description" TEXT,
    "adresse" TEXT NOT NULL,
    "telephone" TEXT NOT NULL,
    "image" TEXT,
    "ouvert" BOOLEAN NOT NULL DEFAULT true,
    "villeId" TEXT NOT NULL,
    "proprietaireId" TEXT,
    "dateCreation" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "dateModification" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Commerce_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "public"."Commerce" ADD CONSTRAINT "Commerce_villeId_fkey" FOREIGN KEY ("villeId") REFERENCES "public"."Ville"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Commerce" ADD CONSTRAINT "Commerce_proprietaireId_fkey" FOREIGN KEY ("proprietaireId") REFERENCES "public"."Utilisateur"("id") ON DELETE SET NULL ON UPDATE CASCADE;
