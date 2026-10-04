import { IsNotEmpty, IsString } from 'class-validator';

export class CreateVilleDto {
  @IsString()
  @IsNotEmpty()
  nom: string;
}