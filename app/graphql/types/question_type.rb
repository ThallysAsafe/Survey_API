module Types
  class QuestionType < BaseObject
    description 'the question'

    field :id, ID, null: false
    field :name, String, null: false
    field :type_question, String, null: true
    field :research_id, Integer, null: false
  end
end
