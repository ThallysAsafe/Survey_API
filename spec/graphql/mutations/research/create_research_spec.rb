require "rails_helper"

module Mutations
  RSpec.describe "mutation CreateResearch" do

    it "creates a Research and returns a research" do
      research_attributes = attributes_for(:research)
      result = SurveyApiSchema.execute(
        query,
        variables: {
          create: { confirm: "true",
          input: {
            title: research_attributes[:title],
            status: research_attributes[:status]
          }
        }
      }
      )
      expect(result["data"]["createResearch"]["research"]).to be_present
    end
    ## tentar criar em situação pra dar erro
    it "creates a Research and returns a research" do
      research_attributes = attributes_for(:research)
      result = SurveyApiSchema.execute(
        query,
        variables: {
          create: { confirm: "true",
          input: {
            title: research_attributes[:title],
            status: research_attributes[:status]
          }
        }
      }
      )
      expect(result["data"]["createResearch"]["research"]).to be_present
    end

    def query
      <<~GQL
      mutation ResearchCreate($create: CreateResearchInput!){
        createResearch(input:$create){
          research
          {
            id
            title
            status
          }
        }
      }
      GQL
    end
  end
end
