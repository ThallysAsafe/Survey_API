module Mutations
  module Question
    class DeleteQuestion < BaseMutation
      argument :id, ID, required: true

      field :question, Types::QuestionType, null: true
      field :errors, [String], null: false

      def resolve(id:)
        question = ::Question.find_by(id: id)

        if question
          delete_question(question)
        else
          { question: nil, errors: ["Pergunta não encontrada"] }
        end
      end

      private

      def delete_question(question)
        if question.destroy
          { question: nil, errors: [] }
        else
          { question: nil, errors: question.errors.full_messages }
        end
      end
    end
  end
end
