import { IsString, MinLength } from 'class-validator';

export class LoginDto {
  @IsString()
  @MinLength(9)
  telephone: string;

  @IsString()
  @MinLength(6)
  motDePasse: string;
}