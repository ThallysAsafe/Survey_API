require "rails_helper"

module Mutations
  RSpec.describe "mutation UpdateResearch" do
    let(:user) { create(:user) }
    it "Update a Research and returns a research" do
      research_attributes = attributes_for(:research)
      user = create(:user, role: 'coordinators')
      research = create(:research)
      result = SurveyApiSchema.execute(
        query,
        variables: {
          update: {
             id: research.id,
            input: {
              title: research_attributes[:title],
              status: research_attributes[:status]
            }
          }
        },
        context: { current_user: user }
      )
      expect(result["data"]["updateResearch"]["research"]).to be_present
      expect(result["data"]["updateResearch"]["research"]["status"]).to be_present
      end
      it "return error in Update a Research, case role user is responders" do
        research_attributes = attributes_for(:research)
        user = create(:user, role: 'responders')
        research = create(:research)
        result = SurveyApiSchema.execute(
          query,
          variables: {
            update: {
               id: research.id,
              input: {
                title: research_attributes[:title],
                status: research.status # ele ira apresentar o mesmo valor q ja tava antes, resumindo só alterando o title
              }
            }
          },
          context: { current_user: user }
        )
        expect(result["data"]["updateResearch"]["errors"]).to_not be_blank
      end
      it "Update a Research, return errors case user no logged" do
        research_attributes = attributes_for(:research)
        user = create(:user, role: 'coordinators')
        research = create(:research)
        result = SurveyApiSchema.execute(
          query,
          variables: {
            update: {
               id: research.id,
              input: {
                title: research.title,
                status: research_attributes[:status] # ele ira apresentar o mesmo valor q ja tava antes, resumindo só alterando o title
              }
            }
          },
        )
        expect(result["data"]["updateResearch"]["errors"]).to_not be_blank
      end


    def query
      <<~GQL
      mutation UpdateResearch($update: UpdateResearchInput!) {
          updateResearch(input:$update) {
        research {
          id
          title
          status
          # Adicione outros campos que você deseja retornar após a atualização
          }
          errors
        }
      }
      GQL
    end
  end
end
