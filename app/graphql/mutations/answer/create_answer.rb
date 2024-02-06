module Mutations
  module Answer
    class CreateAnswer < BaseMutation

      argument :answers, [Types::Inputs::AnswerInputType], required: true

      field :answers, [Types::AnswerType], null: true
      field :errors, [String], null: true

      def resolve(answers:)
        current_user = context[:current_user]

        validate_user(current_user)

        @data = []
        user_id = context[:current_user].id
        answers.each do |answer|
          question = ::Question.find_by(id: answer.question_id)
          question.type_question
          # if (type_question == 'text' &&   options_answer = "single-line" or "mult-line") or ((type_question == 'radio'&& answer.answer.length == 1)) and (type_question == 'checkbox' && answer.answer.length >= 1)
            @data.append({research_id: answer.research_id, question_id: answer.question_id, answer: answer.answer, user_id: user_id})
          end
        end

        if check_research_completion(answers[0].research_id) # Usei o primeiro answer para pegar research_id
            ::Answer.create!(@answer_data)
            # utilizar uma especie de importação all

          { answers: created_records, errors: nil }
        else
          { answers: nil, errors: ['A pesquisa ainda não foi concluída. Responda às outras questões pendentes.'] }
        end
      end

      private

      def check_research_completion(research_id)
        research = ::Research.find(research_id)
        total_questions = research.questions.count
        tamanho_data = @data.length
        if research.status == 'open'
          return total_questions == tamanho_data
        else
          raise GraphQL::ExecutionError,"A pesquisa selecionada está fechada."
        end
        return false
      end

      def validate_user(current_user)
        unless current_user && current_user['role'] == 'coordinators'
          raise GraphQL::ExecutionError, 'Acesso não autorizado'
        end
      end
    end
  end
end
