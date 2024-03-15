terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.40.0"
    }
  }
}
provider "aws" {
  region = "sa-east-1"
  
    }
resource "aws_key_pair" "chave_public" {
  key_name   = "chave_public"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCUjgo4exjoFi8bjFIYSpk7JWEIW7BaoXbjMPTbdrb2IVUlGngmzGESBiX2lhJMr0oJuZdTRMwOsKD2SabSqS2QhlTJd4KfgPyjYEkxHVmt7YPDxhRneXOK4PI1DBfXQ36UHeyA+S6etEpfNMu+kcYCsoamLuHVXR8Kaj8Lps4DDRfqxB2bggoP+9x7jF06WCWY+nxuXnKXfK1LFr4njUDykTJFWw/evxsF072W75y7s86xrJwykIFMJ8oW9FZAgWttIpfH4mmU7EB4eORteMusdk5EI0DCvwkvJAC8pJ3W1fyd7gt34eaYffMqbvwOHNoJXD5lIou1Jh1FgVYg7m0lyefAvLPEnXpNwDmxT7Hsfe5uDHwU8mWF8BC/FKDVQnlkh7nIAoa2kXgzTT007ETBoTXA2mvlGA9J7TLLg2eY+QblV/qvFOmHR+cbSBpOsUKfFY7OfFv5K+qGsT7AWAS/+Cm5IIAwsram0/93er8LsjOVuE/msA1wI7NTWCCtpuR3nQU5IUIqTSX7FCPz203XOfFMvDcXZ4IqA54YcWRkUjcCUJIV8rUTqxjL5WTIue5grHFnTPWKyBGDYWhIpq43OjlX1CSyJai8EkShdk4Cr/2bGZ3m+3Leejcus3UDgUSVrQ2XqaNkuVchp1nt10wnym0H8ayr6EPlnioJIpusEQ== anderson.lorhan7@gmail.com"
  
}
resource "aws_security_group" "grupo" {
  ingress {
    from_port = 0
    to_port =   0
    protocol = "-1"
    self = true
  }

 #RDP ACCESS
  ingress {
    from_port = 3389
    to_port   = 3389
    protocol  = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  #WINRM ACCESS
  ingress {
    from_port = 5986
    to_port = 5986
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_instance" "webserver" {
  count         = 1
  ami           = "ami-0b6b4f4875af503ed"
  instance_type = "t2.micro"
  security_groups = [ aws_security_group.grupo.name ]
  key_name = "chave"

  tags = {
    name = "Webserver"
    type = "server"
  }
}