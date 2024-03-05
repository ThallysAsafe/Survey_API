class Resolvers::ResearchResults < Resolvers::BaseResolver
  description 'Query Posts'

  type Types::ResearchResultType, null: false

  argument :research_id, ID, required: true

  def resolve(**args)
    validate_user(context[:current_user])
    research = Research.find_by(id: args[:research_id])

    unless research && research.status == "closed"
      raise GraphQL::ExecutionError, "Não foi possível buscar os resultados porque a pesquisa está em aberto ou não foi encontrada."
    end

    {
      research_title: research.title,
      question_results: research.questions.map do |question|
        {
          question_title: question.name,
          options: process_checkbox_answers(question.answers.where(question_id: question.id), question)
        }
      end
    }
  end

  private

  def process_checkbox_answers(answers, question)
    all_options = question.options_answer

    options_count = Hash.new(0)

    # Inicializar contagem para todas as opções com zero
    all_options.each { |option| options_count[option] = 0 }

    answers.each do |answer|
      answer.answer.each do |selected_option|
        options_count[selected_option] += 1
      end
    end

    options_count.map do |option_title, response_count|
         {
        option_title: option_title,
        response_count: response_count
      }
    end
  end
end
