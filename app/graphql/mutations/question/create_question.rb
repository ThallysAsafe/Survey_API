module Mutations
  module Question
    class CreateQuestion < BaseMutation
      argument :input, Types::Inputs::QuestionInputType, required: true
      argument :research_id, ID, 'ID of the associated research', required: true
      field :research, Types::ResearchType
      field :question, Types::QuestionType, null: false
      def resolve(**arguments)
        validate_user(context[:current_user], "coordinators")
        QuestionCreator.new(arguments).call
      end
    end
  end
end
