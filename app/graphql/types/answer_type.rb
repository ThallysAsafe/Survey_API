module Types
  class AnswerType < BaseObject
    description 'the answer'

    field :answer, [String], null: false
    field :research_id, Integer, null: false
    field :question_id, Integer, null: false
    field :type_question, String, null: true
  end
end
