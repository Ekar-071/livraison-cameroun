-- CreateTable
CREATE TABLE "public"."Produit" (
    "id" TEXT NOT NULL,
    "nom" TEXT NOT NULL,
    "description" TEXT,
    "prix" DECIMAL(10,2) NOT NULL,
    "image" TEXT,
    "disponible" BOOLEAN NOT NULL DEFAULT true,
    "commerceId" TEXT NOT NULL,
    "dateCreation" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "dateModification" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Produit_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "public"."Produit" ADD CONSTRAINT "Produit_commerceId_fkey" FOREIGN KEY ("commerceId") REFERENCES "public"."Commerce"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
