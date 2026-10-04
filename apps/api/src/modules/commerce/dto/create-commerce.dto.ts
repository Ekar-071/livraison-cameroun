import { IsNotEmpty, IsOptional, IsPhoneNumber, IsString } from 'class-validator';

export class CreateCommerceDto {
  @IsString()
  @IsNotEmpty()
  nom: string;

  @IsString()
  @IsOptional()
  description?: string;

  @IsString()
  @IsNotEmpty()
  adresse: string;

  @IsString()
  @IsNotEmpty()
  telephone: string;

  @IsString()
  @IsNotEmpty()
  villeId: string;

  @IsString()
  @IsOptional()
  image?: string;
}