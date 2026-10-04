import { Module } from '@nestjs/common';

import { PrismaModule } from '../../prisma/prisma.module';
import { VilleController } from './ville.controller';
import { VilleService } from './ville.service';

@Module({
  imports: [PrismaModule],
  controllers: [VilleController],
  providers: [VilleService],
})
export class VilleModule {}