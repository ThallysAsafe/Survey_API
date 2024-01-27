module Mutations
  module Question
    class UpdateQuestion < BaseMutation
      argument :id, ID, required: true
      argument :input, Types::QuestionInputType, required: true

      field :question, Types::QuestionType, null: true
      field :errors, [String], null: false

      def resolve(id:, input:)
        question = ::Question.find_by(id: id)

        if question
          update_question(question, input)
        else
          { question: nil, errors: ["Pergunta não encontrada"] }
        end
      end

      private

      def update_question(question, input)
        if question.update(input.to_h.except(:_destroy))
          { question: question, errors: [] }
        else
          { question: nil, errors: question.errors.full_messages }
        end
      end
    end
  end
end
