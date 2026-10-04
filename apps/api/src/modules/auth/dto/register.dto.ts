import {
  IsEmail,
  IsOptional,
  IsString,
  MinLength,
} from 'class-validator';

export class RegisterDto {
  @IsString()
  prenom: string;

  @IsString()
  nom: string;

  @IsString()
  @MinLength(9)
  telephone: string;

  @IsOptional()
  @IsEmail()
  email?: string;

  @IsString()
  @MinLength(6)
  motDePasse: string;
}