module Types
  class ResearchResultType < Types::BaseObject
    field :research_title, String, null: false, description: "Title of the survey"
    field :question_results, [QuestionResultType], null: false, description: "Results for each question"
  end
end
