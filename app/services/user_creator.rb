class UserCreator < ApplicationService
  def initialize(arguments)
    @arguments = arguments[:input].to_hash

  end

  def call
    create_user
  end

  private

  def create_user
    user = User.create(
      username: @arguments[:username],
      password: @arguments[:password],
      role: @arguments[:role]
      )
    tokens = generate_jwt_token(user)
    if tokens
      { user: user, token: tokens }
    else
      raise GraphQL::ExecutionError.new(I18n.t('token de usuario não foi criada'))
    end
  end


  def generate_jwt_token(user)
    JsonWebToken.encode({user_id: user.id, user_role: user.role})
  end
end
