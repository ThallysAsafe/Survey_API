# frozen_string_literal: true
module Types
  class MutationType < Types::BaseObject
    # TODO: remove me
    field :test_field, String, null: false,
      description: "An example field added by the generator"
    def test_field
      "Hello World"
    end

    field :createUser, mutation: Mutations::CreateUser
    field :loginUser, mutation: Mutations::LoginUser
    
    field :createResearch, mutation: Mutations::Research::CreateResearch

    field :createQuestion, mutation: Mutations::Question::CreateQuestion
  end
end
