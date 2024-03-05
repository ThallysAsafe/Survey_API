module Mutations
  module Research
    class CreateResearch < BaseMutation
      argument :input, Types::Inputs::ResearchInputType, required: true
      argument :confirm, Boolean, required: true


      field :research, Types::ResearchType, null: true
      field :errors, String, null: true
      def resolve(**arguments)
        validate_user(context[:current_user],"coordinators")

        if arguments[:confirm]
          ResearchCreator.new(arguments).call
        else
          {research: nil}
        end
      end
    end
  end
end
