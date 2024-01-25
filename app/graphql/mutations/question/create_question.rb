module Mutations
  module Question
    class CreateQuestion < BaseMutation
      argument :name, String, required: true
      argument :type_question, String, required: true
      argument :research_id, Integer, required: true

      field :research, Types::ResearchType, null: true

      def resolve(name:, type_question:, research_id:)
        @research = ::Research.find(research_id)
        question = @research.questions.create(name: name, type_question: type_question)
        { research: @research, question: question }
      end
    end
  end
end
