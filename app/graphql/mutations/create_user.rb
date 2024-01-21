module Mutations
  class CreateUser < BaseMutation
    argument :username, String, required: true
    argument :password, String, required: true

    field :user, Types::UserType, null: true
    field :token, String, null: true

    def resolve(username:, password:)
      user = User.create(
        username: username,
        password_digest: password
        # Adicione outros campos conforme necessário
      )

      tokens = generate_jwt_token(user)

      # Adicione o token ao objeto user para ser retornado
      user.token = tokens

      { user: user, token: tokens }
    end

    private

    def generate_jwt_token(user)
      JWT.encode({user_id: user.id}, 'secret')
    end
  end
end
