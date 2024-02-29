require "rails_helper"

module Mutations
  RSpec.describe "mutation DeleteQuestion" do

    it "Delete a Question and returns a question nil" do
      question_attributes = attributes_for(:question)
      question = create(:question)
      user = create(:user, role: 'coordinators')
      result = SurveyApiSchema.execute(
        query,
        variables: {
            question:  {
            id: question.id
          }
          }, context: { current_user: user }
      )
      expect(result["data"]["deleteQuestion"]["question"]).to be_nil
    end

    def query
      <<~GQL
        mutation DeleteQuestion($question: DeleteQuestionInput!){
          deleteQuestion(input: $question){
            question {
              name
              id
            }
            errors
          }
        }
      GQL
    end
  end
end
