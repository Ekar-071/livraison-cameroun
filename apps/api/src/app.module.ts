import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';

import { PrismaModule } from './prisma/prisma.module';
import { AuthModule } from './modules/auth/auth.module';
import { VilleModule } from './modules/ville/ville.module';
import { CommerceModule } from './modules/commerce/commerce.module';
import { ProduitModule } from './modules/produit/produit.module';
import { CommandeModule } from './modules/commande/commande.module';

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
    }),
    PrismaModule,
    AuthModule,
    VilleModule,
    CommerceModule,
    ProduitModule,
    CommandeModule,
  ],
})
export class AppModule {}