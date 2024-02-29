module Mutations
  module Research
    class UpdateResearch < Mutations::BaseMutation

      argument :id, ID, required: true
      argument :input, Types::Inputs::ResearchInputType, required: true

      field :research, Types::ResearchType, null: true
      field :errors, [String], null: false

      def resolve(**arguments)
        validate_user(context[:current_user],"coordinators")
        ResearchUpdate.new(arguments).call
      end
    end
  end
end
