module Types
  class ResearchType < BaseObject
    description 'A research'

    field :id, ID, null: false
    field :title, String, null: false
    field :status, String, null: false
    field :questions, [QuestionType], null: true
    field :researchResults, Types::ResearchResultType, null: true
  end
end
