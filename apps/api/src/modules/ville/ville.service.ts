import { BadRequestException, Injectable } from '@nestjs/common';

import { PrismaService } from '../../prisma/prisma.service';
import { CreateVilleDto } from './dto/create-ville.dto';

@Injectable()
export class VilleService {
  constructor(private readonly prisma: PrismaService) {}

  async create(data: CreateVilleDto) {
    const villeExistante = await this.prisma.ville.findUnique({
      where: {
        nom: data.nom,
      },
    });

    if (villeExistante) {
      throw new BadRequestException(
        'Une ville avec ce nom existe déjà.',
      );
    }

    return this.prisma.ville.create({
      data: {
        nom: data.nom,
      },
    });
  }

  async findAll() {
    return this.prisma.ville.findMany({
      orderBy: {
        nom: 'asc',
      },
    });
  }
}