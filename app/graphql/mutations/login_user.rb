
module Mutations
  class LoginUser < BaseMutation
    argument :username, String, required: true
    argument :password, String, required: true

    field :user, Types::UserType, null: true
    field :token, String, null: true
    field :errors, String, null: true

    def resolve(**arguments)
      UserLogin.new(arguments).call
    end
  end
end
