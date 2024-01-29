module Mutations
  class LoginUser < BaseMutation
    argument :username, String, required: true
    argument :password, String, required: true

    field :user, Types::UserType, null: true
    field :token, String, null: true

    def resolve(username:, password:)
      @user = User.find_by(username: username)

      if @user && @user.authenticate(password)
        token = JWT.encode({user_id: @user.id, user_role: @user.role}, 'secret')

        if token
          return {user: @user, token: token}
        end
      end
    end
  end
end
