import {
  IsArray,
  IsEnum,
  IsInt,
  IsNotEmpty,
  IsNumber,
  IsString,
  ValidateNested,
} from 'class-validator';

import { Type } from 'class-transformer';
import { ModePaiement } from '@prisma/client';

class CreateCommandeItemDto {
  @IsString()
  produitId: string;

  @IsInt()
  quantite: number;

  @IsNumber()
  prixUnitaire: number;
}

export class CreateCommandeDto {
  @IsString()
  @IsNotEmpty()
  utilisateurId: string;

  @IsEnum(ModePaiement)
  modePaiement: ModePaiement;

  @IsArray()
  @ValidateNested({ each: true })
  @Type(() => CreateCommandeItemDto)
  items: CreateCommandeItemDto[];
}