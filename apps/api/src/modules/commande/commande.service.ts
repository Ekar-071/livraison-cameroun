import { BadRequestException, Injectable } from '@nestjs/common';

import { PrismaService } from '../../prisma/prisma.service';
import { CreateCommandeDto } from './dto/create-commande.dto';

@Injectable()
export class CommandeService {
  constructor(private readonly prisma: PrismaService) {}

  async create(data: CreateCommandeDto) {
    const utilisateur = await this.prisma.utilisateur.findUnique({
      where: {
        id: data.utilisateurId,
      },
    });

    if (!utilisateur) {
      throw new BadRequestException('Utilisateur introuvable.');
    }

    let montantTotal = 0;

    data.items.forEach((item) => {
      montantTotal += item.prixUnitaire * item.quantite;
    });

    return this.prisma.commande.create({
      data: {
        utilisateurId: data.utilisateurId,
        modePaiement: data.modePaiement,
        montantTotal,

        items: {
          create: data.items.map((item) => ({
            produitId: item.produitId,
            quantite: item.quantite,
            prixUnitaire: item.prixUnitaire,
          })),
        },
      },
      include: {
        items: true,
      },
    });
  }

  findAll() {
    return this.prisma.commande.findMany({
      include: {
        utilisateur: true,
        items: {
          include: {
            produit: true,
          },
        },
      },
      orderBy: {
        dateCreation: 'desc',
      },
    });
  }

  findOne(id: string) {
    return this.prisma.commande.findUnique({
      where: {
        id,
      },
      include: {
        utilisateur: true,
        items: {
          include: {
            produit: true,
          },
        },
      },
    });
  }
}