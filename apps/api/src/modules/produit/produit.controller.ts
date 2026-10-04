import { Body, Controller, Get, Param, Post } from '@nestjs/common';

import { ProduitService } from './produit.service';
import { CreateProduitDto } from './dto/create-produit.dto';

@Controller('produits')
export class ProduitController {
  constructor(private readonly produitService: ProduitService) {}

  @Post()
  create(@Body() data: CreateProduitDto) {
    return this.produitService.create(data);
  }

  @Get()
  findAll() {
    return this.produitService.findAll();
  }

  @Get('commerce/:commerceId')
  findByCommerce(@Param('commerceId') commerceId: string) {
    return this.produitService.findByCommerce(commerceId);
  }
}