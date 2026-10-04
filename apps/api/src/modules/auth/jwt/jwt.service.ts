import { Injectable } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';

@Injectable()
export class TokenService {
  constructor(private readonly jwtService: JwtService) {}

  genererToken(utilisateur: {
    id: string;
    role: string;
    telephone: string;
  }) {
    return this.jwtService.sign({
      sub: utilisateur.id,
      role: utilisateur.role,
      telephone: utilisateur.telephone,
    });
  }
}