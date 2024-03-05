require "rails_helper"

module Mutations
  RSpec.describe "mutation DeleteResearch" do

    it "Delete a Research and returns a question nil" do
      question_attributes = attributes_for(:research)
      research = create(:research)
      user = create(:user, role: 'coordinators')
      result = SurveyApiSchema.execute(
        query,
        variables: {
            research:  {
            id: research.id
          }
          }, context: { current_user: user }
      )
      expect(result["data"]["deleteResearch"]["research"]).to be_nil
    end

    def query
      <<~GQL
        mutation DeleteResearch($research: DeleteResearchInput!){
          deleteResearch(input: $research){
            research {
              id
            }
            errors
          }
        }
      GQL
    end
  end
end
