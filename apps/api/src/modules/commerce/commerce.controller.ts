import { Body, Controller, Get, Param, Post } from '@nestjs/common';

import { CommerceService } from './commerce.service';
import { CreateCommerceDto } from './dto/create-commerce.dto';

@Controller('commerces')
export class CommerceController {
  constructor(private readonly commerceService: CommerceService) {}

  @Post()
  create(@Body() data: CreateCommerceDto) {
    return this.commerceService.create(data);
  }

  @Get()
  findAll() {
    return this.commerceService.findAll();
  }

  @Get('ville/:villeId')
  findByVille(@Param('villeId') villeId: string) {
    return this.commerceService.findByVille(villeId);
  }
}