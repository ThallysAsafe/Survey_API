module Mutations
  module Question
    class UpdateQuestion < BaseMutation
      argument :id, ID, required: true
      argument :update, Types::Inputs::QuestionInputType, required: true

      field :question, Types::QuestionType, null: true
      field :errors, [String], null: false

      def resolve(id:, update:)
        question = ::Question.find_by(id: id)
        if question
          update_question(question, input)
        else
          { question: nil, errors: ["Pergunta não encontrada"] }
        end
      end


      private

      def update_question(question, update)
        options_answer = update[:options_answer]
        
        if question.update(update.to_h.except(:_destroy))
          { question: question, errors: [] }
        else
          { question: nil, errors: question.errors.full_messages }
        end
      end
    end
  end
end
