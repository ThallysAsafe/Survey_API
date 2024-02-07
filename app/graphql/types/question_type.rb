module Types
  class QuestionType < BaseObject
    description 'the question'

    field :id, ID, null: false
    field :name, String, null: false
    field :type_question, String, null: true
    field :research_id, Integer, null: false
    field :options_answer, [String], null: false
    field :answers, [AnswerType], null: true
  end
end
