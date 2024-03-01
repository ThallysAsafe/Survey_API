module Types
  class AnswerType < BaseObject
    description 'the answer'

    field :answer, [String], null: true
    field :research_id, Integer, null: false
    field :question_id, Integer, null: false
  end
end
