module Types
  class QuestionResultType < Types::BaseObject
    field :question_title, String, null: false, description: "Title of the question"
    field :options, [OptionResultType], null: false, description: "Results for each option"
  end
end
