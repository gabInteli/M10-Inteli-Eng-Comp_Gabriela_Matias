---
title: Resolução - Ponderada 3
description: Trabalhando com Imagens em Dispositivos Mobile
---

# Implementação de Interface de Front-end Mobile

Bem-vindos à documentação da nossa atividade ponderada! 
O projeto consiste na construção de um aplicativo híbrido utilizando o framework Flutter e um backend em microsserviços com Flask, Docker e PostgreSQL. A principal funcionalidade do aplicativo é permitir que os usuários realizem login, cadastro, enviem fotos para processamento e visualizem as fotos processadas.

O backend é composto por microsserviços que lidam com diferentes aspectos da aplicação, como autenticação de usuários, processamento de imagens e armazenamento de dados. A utilização de microsserviços permite uma arquitetura modular e escalável, facilitando a manutenção e expansão do sistema.

A documentação fornecida descreve em detalhes as diferentes páginas e funcionalidades do aplicativo Flutter, bem como a estrutura e funcionalidades dos microsserviços no backend. Além disso, são fornecidas instruções para a execução do projeto, tanto da interface com Flutter quanto do backend utilizando Docker Compose.

Com essa abordagem, o projeto busca fornecer uma solução completa e robusta para o processamento de imagens em um ambiente distribuído, aproveitando as tecnologias modernas e boas práticas de desenvolvimento de software.

## Entregáveis

#### Collections do Insomnia: 
[Link Insomnia](https://github.com/gabInteli/M10-Inteli-Eng-Comp_Gabriela_Matias/blob/main/src/ponderada3/src/static/Insomnia_2024-06-04.json)

#### Código Fonte - Serviços e Interface: 
[Link API](https://github.com/gabInteli/M10-Inteli-Eng-Comp_Gabriela_Matias/blob/main/src/ponderada3/src)


### Repositório de Resolução do Projeto

[✔] [Ponderada 3](https://github.com/gabInteli/M10-Inteli-Eng-Comp_Gabriela_Matias/tree/main/src/ponderada3)

### Instruções de Execução do Projeto 🫡

1. Primeiro passo é Clonar o Repositório base: 
```
git clone https://github.com/gabInteli/M10-Inteli-Eng-Comp_Gabriela_Matias.git
```

em seguida acessar a pasta: 
```
cd src/ponderada3/src
```

2. Em seguida basta iniciar o docker que contem o servidor de APIs com: 
```
docker compose -f docker-compose.yaml build
```
```
docker compose -f docker-compose.yaml up
```

Isso iniciará nosso servidor. 

3. Por fim, basta acessar a pasta: 
´´´
cd flutterzin
´´´

Instalar as dependências de Flutter: 

```
flutter pub get
```

Por fim, iniciar o arquivo flutter da interface com o Emulador: 
```
flutter run
```

# Documentação do Aplicativo Flutter

## 1. Login

**Descrição:** Página de login onde os usuários podem fazer login em suas contas.

**Recursos:**
- Campos de entrada para nome de usuário e senha.
- Botão de login que envia as credenciais para autenticação.
- Link para a página de cadastro para novos usuários.

**Implementação:**
- Utiliza a autenticação básica com a API do backend.
- Validação dos campos de entrada.
- Redirecionamento para a página principal após o login bem-sucedido.

## 2. Cadastro

**Descrição:** Página de cadastro para novos usuários criarem uma conta.

**Recursos:**
- Campos de entrada para nome de usuário, senha e confirmação de senha.
- Botão de cadastro que envia as informações para criação da conta.
- Link para a página de login para usuários existentes.

**Implementação:**
- Validação dos campos de entrada.
- Verificação de disponibilidade do nome de usuário.
- Criptografia da senha antes de enviar para o backend.

## 3. Registro de Foto

**Descrição:** Página onde os usuários podem tirar fotos para enviar ao backend para processamento.

**Recursos:**
- Botão para abrir a câmera do dispositivo.
- Botão para capturar a foto.
- Botão para enviar a foto para o backend.

**Implementação:**
- Utiliza a biblioteca de câmera do Flutter para acessar a câmera do dispositivo.
- Compressão da imagem antes de enviar para o backend.
- Envio da imagem para o endpoint correto do backend.

## 4. Galeria e Aplicação de Filtro

**Descrição:** Página onde os usuários podem visualizar suas fotos enviadas e aplicar filtros nelas.

**Recursos:**
- Exibição das fotos enviadas pelo usuário.
- Opções de filtros para aplicar nas fotos.
- Botão para enviar a foto processada para o backend.

**Implementação:**
- Recuperação das fotos do usuário do backend.
- Implementação de filtros de imagem utilizando bibliotecas do Flutter.
- Envio da foto processada para o backend.

# Estrutura do Backend em Microsserviços

## 1. API Principal (auth)

**Descrição:** Microsserviço responsável pela autenticação de usuários.

**Endpoint:**
- /user: Criação de novos usuários.
- /userauth: Autenticação de usuários.

**Funcionalidades:**
- Criação e autenticação de usuários.
- Geração de tokens de autenticação.

## 2. API de Processamento de Imagem

**Descrição:** Microsserviço responsável pelo processamento de imagens enviadas pelos usuários.

**Endpoint:**
- /process_image: Processamento de imagens enviadas pelos usuários.

**Funcionalidades:**
- Recebimento e processamento de imagens.
- Aplicação de filtros nas imagens.
- Retorno das imagens processadas.

## 3. Serviço de Banco de Dados (db)

**Descrição:** Serviço de banco de dados PostgreSQL utilizado pelos microsserviços para armazenar dados dos usuários e das imagens processadas.

## 4. Dockerfile e docker-compose.yml

**Descrição:** Arquivos de configuração do Docker para conteinerização dos microsserviços e do banco de dados.

**Funcionalidades:**
- Conteinerização dos microsserviços e do banco de dados.
- Definição das dependências e configurações necessárias para execução dos serviços em containers.

## Demonstração de Funcionamento da Interface

<iframe width="560" height="315" src="https://www.youtube.com/embed/FMNL3bScHhs?si=7BBM2VgQbnBlKLth" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>
