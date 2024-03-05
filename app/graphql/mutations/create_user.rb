module Mutations
  class CreateUser < BaseMutation
    argument :input, Types::Inputs::UserInputType, required: true

    field :user, Types::UserType, null: true
    field :errors, String, null: true

    def resolve(**arguments)
      UserCreator.new(arguments).call
    end
  end
end
