import { BadRequestException, Injectable } from '@nestjs/common';

import { PrismaService } from '../../prisma/prisma.service';
import { CreateCommerceDto } from './dto/create-commerce.dto';

@Injectable()
export class CommerceService {
  constructor(private readonly prisma: PrismaService) {}

  async create(data: CreateCommerceDto) {
    const ville = await this.prisma.ville.findUnique({
      where: {
        id: data.villeId,
      },
    });

    if (!ville) {
      throw new BadRequestException('Ville introuvable.');
    }

    return this.prisma.commerce.create({
      data: {
        nom: data.nom,
        description: data.description,
        adresse: data.adresse,
        telephone: data.telephone,
        image: data.image,
        villeId: data.villeId,
      },
    });
  }

  async findAll() {
    return this.prisma.commerce.findMany({
      include: {
        ville: true,
      },
      orderBy: {
        nom: 'asc',
      },
    });
  }

  async findByVille(villeId: string) {
    return this.prisma.commerce.findMany({
      where: {
        villeId,
        ouvert: true,
      },
      include: {
        ville: true,
      },
      orderBy: {
        nom: 'asc',
      },
    });
  }
}