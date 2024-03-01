
class UserLogin < ApplicationService
  def initialize(arguments)
    @arguments = arguments
  end

  def call
    login_user
  end

  private

  def login_user
    @user = User.find_by(username: @arguments[:username])

      if @user && @user.authenticate(@arguments[:password])
        token = generate_jwt_token()

        if token
          return {user: @user, token: token}
        end
      else
        return {errors: "Usuario ou senha inválidos, porfavor tente novamente."}
      end
  end

  def generate_jwt_token
    JsonWebToken.encode({user_id: @user.id, user_role: @user.role})
  end
end
