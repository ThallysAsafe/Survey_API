module Mutations
  module Research
    class CreateResearch < BaseMutation
      argument :input, Types::Inputs::ResearchInputType, required: true
      argument :confirm, String, required: true


      field :research, Types::ResearchType, null: true
      field :errors, String, null: true
      def resolve(**arguments)
        validate_user(context[:current_user],"coordinators")

        if arguments[:confirm] == "true"
          ResearchCreator.new(arguments).call
        else
          {research: nil}
        end
      end
    end
  end
end
