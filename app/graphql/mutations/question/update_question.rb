module Mutations
  module Question
    class UpdateQuestion < BaseMutation
      argument :id, ID, required: true
      argument :update, Types::Inputs::QuestionInputType, required: true

      field :question, Types::QuestionType, null: true
      field :errors, [String], null: false

      def resolve(**arguments)
        validate_user(context[:current_user], "coordinators")
        QuestionUpdate.new(arguments).call
      end
    end
  end
end
