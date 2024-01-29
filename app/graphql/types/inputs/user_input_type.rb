module Types::Inputs
  class UserInputType < GraphQL::Schema::InputObject
    description "Attributes for logging in a user"

    argument :username, String, required: true, description: "User's username"
    argument :password, String, required: true, description: "User's password"
    argument :role, String, required: false, description: "User's role",  default_value: "responder"
  end
end
  