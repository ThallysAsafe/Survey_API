# SurveyAPI
 
## Projeto
### Informações:
#### Projeto SurveyAPI, é uma aplicação que não é destinada ao desenvolvimento de front-end; seu único propósito é fornecer uma API e entregar dados de teste JSON.

# Tecnologias utilizada:

- [Ruby-on-rails](https://rubygems.org/gems/rails/versions/7.0.8) 
- [Ruby](https://www.ruby-lang.org/en/news/2023/03/30/ruby-3-2-2-released/)
- [Graphql](https://rubygems.org/gems/graphql/versions/2.2.3)
# Na parte de Testes:
- [rspec-rails](https://rubygems.org/gems/rspec-rails/versions/5.0.0)
- [factory-bot-rails](https://rubygems.org/gems/factory_bot_rails/versions/6.4.3)
- [faker](https://rubygems.org/gems/faker/versions/3.2.3?locale=pt-BR)

## Criptografia de senhas e Gerador Tokens
- [bcrypt](https://rubygems.org/gems/bcrypt/versions/3.1.11?locale=pt-BR)
- [jwt](https://rubygems.org/gems/jwt/versions/1.5.4?locale=pt-BR)

## Tipos de Usuários

Essa API oferece suporte a dois tipos de usuários: 'responders' (Respondentes de Pesquisa) e 'coordinators' (Administradores de Pesquisa). Essa distinção é importante para controlar o acesso e as permissões dentro da api.

  ### Usuário 'responder' (Respondentes da Pesquisa)

  Os usuários 'responder' são os participantes normais do sistema e têm permissões padrão. Eles podem:

  - Acessar e responder a pesquisas.
  - Visualizar os resultados das pesquisas.

  ### Usuário 'coordinator' (Administrador de Pesquisa)

  Os usuários 'coordinator' são os Coordenadores de Pesquisa e possuem permissões extras para a criação e manipulação de pesquisas. Eles têm as seguintes permissões adicionais:

  - Criar e Editar pesquisas.
  - Criar, Editar e Excluir perguntas.
  

Certifique-se de conceder o tipo de usuário 'coordinators' apenas a pessoas autorizadas, pois elas têm acesso às funcionalidades da API.
Na parte de authenticação da API foi utilizado o JWT(Json Web Token)
* No final do projeto existe um arquivo chamado Insomnia_2024-03-05.json contendo as queries e mutations. Obs: esse arquivo deve ser importado no Insomnia. Depois de importado, você irá encontrar as seguintes queries e mutations:

# Surveys

- **Criar uma nova pesquisa**: `Mutation CreateResearch` Apenas coordinators
- **Atualizar uma pesquisa existente**: `Mutation UpdateResearch` Apenas coordinators
- **Excluir uma pesquisa**: `Mutation DeleteResearch` Apenas coordinators
- **Listar todas as pesquisas abertas**: `Query OpenResearch`
- **Listar todas as pesquisas fechadas**: `Query ClosedResearch` 
- **Detalhes de uma pesquisa específica**: `Query FindResearch`

# Questions

- **Criar uma nova pergunta para uma pesquisa**: `Mutation CreateQuestion` Apenas coordinators
- **Atualizar uma pergunta em uma pesquisa**: `Mutation UpdateQuestion` Apenas coordinators
- **Excluir uma pergunta de uma pesquisa**: `Mutation DeleteQuestion` Apenas coordinators

# Answers

- **Criar uma nova resposta para uma pesquisa**: `Mutation CreateAnswer`

# Users

- **Registrar um novo usuário**: `Mutation CreateUser`
- **Autenticar um usuário**: `Mutation LoginUser`
# ResearchResults
- **Mostrar os Resultados de uma determinada pesquisa fechada**: `Query ResearchResults`
## Para executar O Projeto
- Clone o repositório em sua máquina:

  ```bash
  $ git clone https://github.com/ThallysAsafe/Survey_API.git
  ```
- Acesse o repositório usando:
  ```bash
  $ cd SurveyAPI
  ```
- Instalando as dependências:
  ```bash
  $ bundle install
  ```
- Crie o banco de dados:
  ```bash
  $ rails db:create
  ```
- Executando a migration:
  ```bash
  $ rails db:migrate
  ```
- Iniciando API:
  ```bash
  $ rails s
  ```
  ## Observações

- **Login e Token de Acesso**:
  - Para acessar qualquer rota da API, é necessário realizar o processo de login na aplicação.
  - Primeiro necessário fazer o registro da conta no createUser.
  - O loginUser envolve o envio de uma solicitação para obter um token de acesso.
  - Para acessar as querys é necessário inserir o token, sem ele não conseguirar acessar a query, apresentando como resposta "acesso negado"
  
