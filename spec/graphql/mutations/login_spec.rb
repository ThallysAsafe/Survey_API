require "rails_helper"

module Mutations
  RSpec.describe "mutation loginUser" do
    # No seu teste loginUser
  it "authenticates the user returning a token" do
    user = create(:user)
    result = SurveyApiSchema.execute(query,variables:{login: {username: user.username, password: user.password}})


    expect(result["data"]["loginUser"]["token"]).to be_present
  end

  # No seu teste para falha de autenticação
  it "returns an error when authentication fails" do
    user = create(:user)
    result = SurveyApiSchema.execute(query,variables:{login: {username: user.username, password: "senha_incorreta"}})

    expect(result["data"]["loginUser"]["user"]).to be_blank
    expect(result["data"]["loginUser"]["token"]).to be_blank
  end

    def query
      <<~GQL
      mutation LoginUser($login: LoginUserInput!) {
        loginUser(input: $login){
          user {
            username
          }
          token
        }
      }
      GQL
    end
  end
end
