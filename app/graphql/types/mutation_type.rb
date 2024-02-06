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
    field :updateResearch, mutation: Mutations::Research::UpdateResearch

    field :createQuestion, mutation: Mutations::Question::CreateQuestion
    field :updateQuestion, mutation: Mutations::Question::UpdateQuestion
    field :deleteQuestion, mutation: Mutations::Question::DeleteQuestion

    field :createAnswer, mutation: Mutations::Answer::CreateAnswer
  end
end
