import { BadRequestException, Injectable } from '@nestjs/common';

import { PrismaService } from '../../prisma/prisma.service';
import { CreateProduitDto } from './dto/create-produit.dto';

@Injectable()
export class ProduitService {
  constructor(private readonly prisma: PrismaService) {}

  async create(data: CreateProduitDto) {
    const commerce = await this.prisma.commerce.findUnique({
      where: {
        id: data.commerceId,
      },
    });

    if (!commerce) {
      throw new BadRequestException('Commerce introuvable.');
    }

    return this.prisma.produit.create({
      data: {
        nom: data.nom,
        description: data.description,
        prix: data.prix,
        image: data.image,
        disponible: data.disponible ?? true,
        commerceId: data.commerceId,
      },
    });
  }

  async findAll() {
    return this.prisma.produit.findMany({
      include: {
        commerce: true,
      },
      orderBy: {
        nom: 'asc',
      },
    });
  }

  async findByCommerce(commerceId: string) {
    return this.prisma.produit.findMany({
      where: {
        commerceId,
        disponible: true,
      },
      orderBy: {
        nom: 'asc',
      },
    });
  }
}