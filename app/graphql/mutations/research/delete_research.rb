module Mutations
  module Research
    class DeleteResearch < Mutations::BaseMutation

      argument :id, ID, required: true
      field :research, Types::ResearchType, null: true
      field :errors, [String], null: false

      def resolve(**arguments)
        validate_user(context[:current_user],"coordinators")
        ResearchDelete.new(arguments).call
      end
    end
  end
end
