require "rails_helper"

module Mutations
  RSpec.describe "mutation createAnswer" do

    it "creates a Answer and returns a Answer" do
      user = create(:user, role: 'responders')
      research = build(:research, status: 'open')
      questions = create_list(:question, 10, research: research)

      # Certifique-se de que as respostas estejam associadas às perguntas corretas
      answers = questions.map do |question|
        create(:answer, research: research, question: question)
      end

      response_data = answers.map do |answer|
        {
          researchId: answer.research_id,
          questionId: answer.question_id,
          answer: answer.answer  # Defina a resposta conforme necessário
        }
      end

      result = SurveyApiSchema.execute(
        query,
        variables: {
            create: {
            confirm: 'true',
            response: response_data # voltar aqui erro, sobre ele ta conseguindo imprimir com as resposta tudo certinho mas ele não ta conseguindo entrar os 10 dados de uma vez
        }
      },
      context: { current_user: user }
      )
      expect(result["data"]["createAnswer"]).to be_present
      expect(result["data"]["createAnswer"]["answers"]).to be_present

    end

    def query
      <<~GQL
        mutation CreateAnswer($create: CreateAnswerInput!){
          createAnswer(input: $create) {
            answers {
              answer
              researchId
              questionId
            }
          errors
          }
        }
      GQL
    end
  end
end
