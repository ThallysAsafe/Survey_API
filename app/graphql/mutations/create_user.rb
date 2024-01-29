module Mutations
  class CreateUser < BaseMutation
    argument :input, Types::Inputs::UserInputType, required: true

    field :user, Types::UserType, null: true
    field :token, String, null: true

    def resolve(input:)
      username = input[:username]
      password = input[:password]
      role = input[:role] || "responder"
      user = User.create(
        username: username,
        password: password,
        role: role
        # Adicione outros campos conforme necessário
      )

      tokens = generate_jwt_token(user)

      # Adicione o token ao objeto user para ser retornado

      { user: user, token: tokens }
    end

    private

    def generate_jwt_token(user)
      JWT.encode({user_id: user.id, user_role: user.role}, 'secret')
    end
  end
end
