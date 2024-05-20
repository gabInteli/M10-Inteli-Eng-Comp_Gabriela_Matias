---
title: Resolução - Ponderada 3
description: Trabalhando com Imagens em Dispositivos Mobile
---

# Implementação de Interface de Front-end Mobile

Bem-vindos à documentação da API da nossa atividade ponderada! 
Esta documentação foi criada para fornecer uma visão geral e instruções detalhadas sobre como utilizar e contribuir para a API que estamos desenvolvendo como parte deste projeto.

## Visão Geral
Nossa atividade ponderada envolve a construção de APIs, com o objetivo principal de permitir que os usuários realizem operações CRUD (Create, Read, Update, Delete) em tarefas. Isso sendo desenvolvido por meio de uma interface mobile construída com Flutter.

## Entregáveis

#### Collections do Insomnia: 
[Link Insomnia](https://github.com/gabInteli/M10-Inteli-Eng-Comp_Gabriela_Matias/blob/main/src/ponderada2/src/static/Insomnia_2024-05-20.json)
#### YAML do OpenAPI (Swagger): 
[Link Swagger](https://github.com/gabInteli/M10-Inteli-Eng-Comp_Gabriela_Matias/blob/main/src/ponderada2/src/static/swagger.yaml) - Você também pode acessar o swagger acessando o servidor local e a rota: '/docs'.
#### Código Fonte da API: 
[Link API](https://github.com/gabInteli/M10-Inteli-Eng-Comp_Gabriela_Matias/blob/main/src/ponderada2/src/app.py)


### Repositório de Resolução do Projeto

[✔] [Ponderada 2](https://github.com/gabInteli/M10-Inteli-Eng-Comp_Gabriela_Matias/tree/main/src/ponderada2)

### Instruções de Execução da API: Esse você encontra aqui ! 🫡

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

### Autenticação - Níveis 
Para criar uma API com niveis de seguraça, temos rotas que necessitam de autenticação para o acesso e rotas que não necessitam: 

#### Rotas sem Autenticação: 
- "/auth" - Aplica a criação da Autenticação


#### Rotas com Autenticação: 
- "/tasks" [GET] - Visualização de Todas as Tasks
- "/tasks" [POST]- Criação de Novas Tasks
- "/tasks/<id>" [GET]- Visualização de Task Específica
- "/tasks/<id>" [UPDATE]- Atualização de Task Específica
- "/tasks/<id>" [DELETE]- Deleção de Task Específica

## Demonstração de Funcionamento das APIs

<iframe width="560" height="315" src="https://www.youtube.com/embed/p5th6yFh63M?si=iphQuiNUkLK6x4hx" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>

## Demonstração de Funcionamento da Interface

<iframe width="560" height="315" src="https://www.youtube.com/embed/HtOgNZyJFug?si=YQQFviA6lZSKFbZH" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>