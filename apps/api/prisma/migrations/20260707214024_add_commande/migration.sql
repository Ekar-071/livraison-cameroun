-- CreateEnum
CREATE TYPE "public"."StatutCommande" AS ENUM ('EN_ATTENTE', 'CONFIRMEE', 'EN_PREPARATION', 'EN_LIVRAISON', 'LIVREE', 'ANNULEE');

-- CreateEnum
CREATE TYPE "public"."ModePaiement" AS ENUM ('ESPECES', 'ORANGE_MONEY', 'MTN_MOMO');

-- CreateTable
CREATE TABLE "public"."Commande" (
    "id" TEXT NOT NULL,
    "utilisateurId" TEXT NOT NULL,
    "montantTotal" DECIMAL(10,2) NOT NULL,
    "statut" "public"."StatutCommande" NOT NULL DEFAULT 'EN_ATTENTE',
    "modePaiement" "public"."ModePaiement" NOT NULL,
    "dateCreation" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "dateModification" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Commande_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."CommandeItem" (
    "id" TEXT NOT NULL,
    "commandeId" TEXT NOT NULL,
    "produitId" TEXT NOT NULL,
    "quantite" INTEGER NOT NULL,
    "prixUnitaire" DECIMAL(10,2) NOT NULL,
    "dateCreation" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "CommandeItem_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "public"."Commande" ADD CONSTRAINT "Commande_utilisateurId_fkey" FOREIGN KEY ("utilisateurId") REFERENCES "public"."Utilisateur"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."CommandeItem" ADD CONSTRAINT "CommandeItem_commandeId_fkey" FOREIGN KEY ("commandeId") REFERENCES "public"."Commande"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."CommandeItem" ADD CONSTRAINT "CommandeItem_produitId_fkey" FOREIGN KEY ("produitId") REFERENCES "public"."Produit"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
