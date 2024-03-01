require "rails_helper"

module Mutations
  RSpec.describe "mutation CreateQuestion" do

    it "creates a Question and returns a question" do
      question_attributes = attributes_for(:question)
      user = create(:user, role: 'coordinators')
      result = SurveyApiSchema.execute(
        query,
        variables: {
            create: {
            researchId: question_attributes[:research_id],
            input: {
            name: question_attributes[:name],
            typeQuestion: question_attributes[:type_question],
            optionsAnswer: question_attributes[:options_answer]
          }
        }
      }, context: { current_user: user }
      )
      expect(result["errors"]).to be_nil
      expect(result["data"]["createQuestion"]).to be_present
      expect(result["data"]["createQuestion"]["question"]).to be_present
    end

    def query
      <<~GQL
            mutation CreateQuestion($create: CreateQuestionInput!) {
        createQuestion(input: $create) {
          question {
            id
            name
            typeQuestion
            researchId
            optionsAnswer
            }
          }
        }

      GQL
    end
  end
end
