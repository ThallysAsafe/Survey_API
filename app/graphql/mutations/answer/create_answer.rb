module Mutations
  module Answer
    class CreateAnswer < BaseMutation

      argument :answers, [Types::Inputs::AnswerInputType], required: true
      argument :confirm, String
      field :answers, [Types::AnswerType], null: true
      field :errors, [String], null: true

      def resolve(answers:,confirm:)
        current_user = context[:current_user]

        validate_user(current_user)
        if confirm == 'true'
          create_answer(answers)
        else
          { answers: nil, errors: ["Resposta cancelada com sucesso"] }
        end

      end

      private

      def create_answer(answers)

        @data = []
        user_id = context[:current_user].id
        answers.each do |answer|

          params_answer(answer,user_id)
        end

        if check_research_completion(answers[0].research_id)
          created_answer = ::Answer.insert_all(@data)


          { answers: created_answer, errors: nil }
        else
          { answers: nil, errors: ['A pesquisa ainda não foi concluída. Responda às outras questões pendentes.'] }
        end
      end

      def params_answer(answer, user_id)
        question = ::Question.find_by(id: answer.question_id)

        if (question.type_question == 'text' && (question.options_answer[0] == "single-line" || question.options_answer[0] == "mult-line")) || ((question.type_question == 'radio' && answer.answer.length == 1)) || (question.type_question == 'checkbox' && (answer.answer.length >= 1 && answer.answer.length <= 5))
          if question.type_question == 'text' &&  question.options_answer[0] == "single-line" && answer.answer[0].length >= 120
            raise GraphQL::ExecutionError, "Tamanho da resposta acima do esperado, resposta aceita só abaixo de 80 caracteres."
          end

          @data.append({research_id: answer.research_id, question_id: answer.question_id, answer: answer.answer, user_id: user_id})
        else
          raise GraphQL::ExecutionError,"Resposta Inválida, porfavor revise as respostas se está dentro dos parametros"
        end
      end

      def check_research_completion(research_id)
        research = ::Research.find(research_id)
        total_questions = research.questions.count
        answered_questions = research.questions.joins(:answers).distinct.count # tenho que remover isso
        tamanho_data = @data.length
        if research.status == 'open'
          return total_questions == (tamanho_data + answered_questions)
        else
          raise GraphQL::ExecutionError,"A pesquisa selecionada está fechada."
        end
        return false
      end

      def validate_user(current_user)
        unless current_user && current_user['role'] == 'responders'
          raise GraphQL::ExecutionError, 'Acesso não autorizado'
        end
      end
    end
  end
end
