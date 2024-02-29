require "rails_helper"

module Mutations
  RSpec.describe "mutation CreateUser" do
    it "creates a user and returns a token" do
      user_attributes = attributes_for(:user)
      result = SurveyApiSchema.execute(
        query,
        variables: {
          create: { input: {
            username: user_attributes[:username],
            password: user_attributes[:password],
            role: user_attributes[:role]
          }}
        }
      )
      expect(result["data"]["createUser"]["user"]).to be_present
      expect(result["data"]["createUser"]["token"]).to be_present
    end

    it "returns a user created with the role field with the result responds by default, if you have not added the role" do
      user_attributes = attributes_for(:user)
      result = SurveyApiSchema.execute(
        query,
        variables: {
          create: { input: {
            username: user_attributes[:username],
            password: user_attributes[:password]
          }}
        }
      )
      p result
      expect(result["data"]["createUser"]["user"]["role"]).to be_present
    end

    def query
      <<~GQL
        mutation CreateUser($create: CreateUserInput!) {
          createUser(input: $create){
            user {
              id
              username
              role
            }
            token
          }
        }
      GQL
    end
  end
end
