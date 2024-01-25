module Types
  class ResearchType < BaseObject
    description 'A research'

    field :id, ID, null: false
    field :title, String, null: false
    field :questions, [QuestionType], null: true
  end
end
