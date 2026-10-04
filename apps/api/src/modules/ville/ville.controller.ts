import { Body, Controller, Get, Post } from '@nestjs/common';

import { VilleService } from './ville.service';
import { CreateVilleDto } from './dto/create-ville.dto';

@Controller('villes')
export class VilleController {
  constructor(private readonly villeService: VilleService) {}

  @Post()
  create(@Body() data: CreateVilleDto) {
    return this.villeService.create(data);
  }

  @Get()
  findAll() {
    return this.villeService.findAll();
  }
}