import { Body, Controller, Get, Param, Post } from '@nestjs/common';

import { CommandeService } from './commande.service';
import { CreateCommandeDto } from './dto/create-commande.dto';

@Controller('commandes')
export class CommandeController {
  constructor(
    private readonly commandeService: CommandeService,
  ) {}

  @Post()
  create(@Body() data: CreateCommandeDto) {
    return this.commandeService.create(data);
  }

  @Get()
  findAll() {
    return this.commandeService.findAll();
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.commandeService.findOne(id);
  }
}