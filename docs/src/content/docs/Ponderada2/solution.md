---
title: Resolução - Ponderada 2
description: Desenvolvimento e execução da ponderada desenvolvida para entrega.
---

# Implementação de Interface de Front-end Mobile

Bem-vindos à documentação da API da nossa atividade ponderada! 
Esta documentação foi criada para fornecer uma visão geral e instruções detalhadas sobre como utilizar e contribuir para a API que estamos desenvolvendo como parte deste projeto.

## Visão Geral
Nossa atividade ponderada envolve a construção de APIs, com o objetivo principal de permitir que os usuários realizem operações CRUD (Create, Read, Update, Delete) em tarefas. Isso sendo desenvolvido por meio de uma interface mobile construída com Flutter.

## Entregáveis

#### Collections do Insomnia: 
[Link Insomnia](https://github.com/gabInteli/M10-Inteli-Eng-Comp_Gabriela_Matias/blob/main/src/ponderada1/src/insomnia.json)
#### YAML do OpenAPI (Swagger): 
[Link Swagger](https://github.com/gabInteli/M10-Inteli-Eng-Comp_Gabriela_Matias/blob/main/src/ponderada1/src/swagger.yaml) - Você também pode acessar o swagger acessando o servidor local e a rota: '/docs'.
#### Código Fonte da API: 
[Link API](https://github.com/gabInteli/M10-Inteli-Eng-Comp_Gabriela_Matias/blob/main/src/ponderada1/src/src/main.py)

#### Instruções de Execução da API: Esse você encontra aqui ! 🫡

### Repositório de Resolução do Projeto

[✔] [Ponderada 2](https://github.com/gabInteli/M10-Inteli-Eng-Comp_Gabriela_Matias/tree/main/src/ponderada2)

## Requisitos - Instalando Dependências 

1. Primeiro passo é Clonar o Repositório base: 
```
git clone https://github.com/gabInteli/M10-Inteli-Eng-Comp_Gabriela_Matias.git
```

em seguida acessar a pasta: 
```
cd src/ponderada2/src
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