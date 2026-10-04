import { BadRequestException, Injectable } from '@nestjs/common';
import * as bcrypt from 'bcrypt';

import { PrismaService } from '../../prisma/prisma.service';
import { LoginDto } from './dto/login.dto';
import { RegisterDto } from './dto/register.dto';
import { TokenService } from './jwt/jwt.service';

@Injectable()
export class AuthService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly tokenService: TokenService,
  ) {}

  async register(data: RegisterDto) {
    const utilisateurExistant = await this.prisma.utilisateur.findFirst({
      where: {
        OR: [
          { telephone: data.telephone },
          { email: data.email },
        ],
      },
    });

    if (utilisateurExistant) {
      throw new BadRequestException(
        'Un utilisateur avec ce téléphone ou cet e-mail existe déjà.',
      );
    }

    const motDePasseHash = await bcrypt.hash(data.motDePasse, 10);

    const utilisateur = await this.prisma.utilisateur.create({
      data: {
        prenom: data.prenom,
        nom: data.nom,
        telephone: data.telephone,
        email: data.email,
        motDePasse: motDePasseHash,
        role: 'CLIENT',
      },
    });

    return {
      id: utilisateur.id,
      prenom: utilisateur.prenom,
      nom: utilisateur.nom,
      telephone: utilisateur.telephone,
      email: utilisateur.email,
      role: utilisateur.role,
    };
  }

  async login(data: LoginDto) {
    const utilisateur = await this.prisma.utilisateur.findUnique({
      where: {
        telephone: data.telephone,
      },
    });

    if (!utilisateur) {
      throw new BadRequestException('Utilisateur introuvable');
    }

    const motDePasseOk = await bcrypt.compare(
      data.motDePasse,
      utilisateur.motDePasse,
    );

    if (!motDePasseOk) {
      throw new BadRequestException('Mot de passe incorrect');
    }

    const accessToken = this.tokenService.genererToken({
      id: utilisateur.id,
      role: utilisateur.role,
      telephone: utilisateur.telephone,
    });

    return {
      accessToken,
      utilisateur: {
        id: utilisateur.id,
        prenom: utilisateur.prenom,
        nom: utilisateur.nom,
        telephone: utilisateur.telephone,
        email: utilisateur.email,
        role: utilisateur.role,
      },
    };
  }
}