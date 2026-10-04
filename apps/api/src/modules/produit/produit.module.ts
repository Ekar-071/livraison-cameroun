import { Module } from '@nestjs/common';

import { PrismaModule } from '../../prisma/prisma.module';
import { ProduitController } from './produit.controller';
import { ProduitService } from './produit.service';

@Module({
  imports: [PrismaModule],
  controllers: [ProduitController],
  providers: [ProduitService],
})
export class ProduitModule {}