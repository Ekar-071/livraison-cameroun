import { Module } from '@nestjs/common';

import { PrismaModule } from '../../prisma/prisma.module';
import { CommandeController } from './commande.controller';
import { CommandeService } from './commande.service';

@Module({
  imports: [PrismaModule],
  controllers: [CommandeController],
  providers: [CommandeService],
})
export class CommandeModule {}