require "rails_helper"

module Mutations
  RSpec.describe "mutation UpdateQuestion" do

    it "Update a Question and returns a question" do
      question_attributes = attributes_for(:question)
      user = create(:user, role: 'coordinators')
      question = create(:question)
      result = SurveyApiSchema.execute(
        query,
        variables: {
            updatequestion: {
            id: question.id,
            update: {
            name: question_attributes[:name],
            typeQuestion: question_attributes[:type_question],
            optionsAnswer: question_attributes[:options_answer]
          }
        }
        }, context: { current_user: user }
      )
      expect(result["data"]["updateQuestion"]).to be_present
      expect(result["data"]["updateQuestion"]["question"]).to be_present
    end

    def query
      <<~GQL
        mutation UpdateQuestion($updatequestion: UpdateQuestionInput!){
          updateQuestion(input: $updatequestion ) {
            question{
              name
              id
              typeQuestion
            }
            errors
          }
        }
      GQL
    end
  end
end
