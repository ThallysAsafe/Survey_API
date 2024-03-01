module Mutations
  module Question
    class DeleteQuestion < BaseMutation
      argument :id, ID, required: true

      field :question, Types::QuestionType, null: true
      field :errors, [String], null: false

      def resolve(**arguments)
        validate_user(context[:current_user], "coordinators")
        QuestionDelete.new(arguments).call
      end
    end
  end
end
