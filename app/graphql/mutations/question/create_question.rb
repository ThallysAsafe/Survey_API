module Mutations
  module Question
    class CreateQuestion < BaseMutation
      argument :input, Types::Inputs::QuestionInputType, required: true
      argument :research_id, ID, 'ID of the associated research', required: true
      field :research, Types::ResearchType
      field :question, Types::QuestionType, null: false
      def resolve(input:, research_id:) # resolver isso dpsd
        name = input[:name]
        type_question = input[:type_question]
        options_answer = input[:options_answer]
        unless (1 <= options_answer.length && options_answer.length <= 5) || type_question == "text"
          raise GraphQL::ExecutionError, 'As opções de resposta tem que ser entre 1 a 5 opções'
        end

        research = ::Research.find(research_id)
        question = ::Question.create(
          name: name,
          type_question: type_question,
          research_id: research_id,
         options_answer: options_answer )
        { question: question }
      end
    end
  end
end
