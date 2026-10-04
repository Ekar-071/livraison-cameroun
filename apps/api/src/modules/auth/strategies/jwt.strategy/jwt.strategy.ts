import { Injectable } from '@nestjs/common';
import { PassportStrategy } from '@nestjs/passport';
import { Strategy, ExtractJwt } from 'passport-jwt';
import { PrismaService } from '../../../../prisma/prisma.service';

@Injectable()
export class JwtStrategy extends PassportStrategy(Strategy) {
  constructor(private readonly prisma: PrismaService) {
    super({
      jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
      ignoreExpiration: false,
      secretOrKey: process.env.JWT_SECRET!,
    });
  }

  async validate(payload: any) {
    const utilisateur = await this.prisma.utilisateur.findUnique({
      where: { id: payload.sub },
      select: {
        id: true,
        prenom: true,
        nom: true,
        email: true,
        telephone: true,
        role: true,
      },
    });

    return utilisateur;
  }
}