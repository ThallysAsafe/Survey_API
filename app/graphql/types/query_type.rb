# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :node, Types::NodeType, null: true do
      argument :id, ID, required: true
    end

    def node(id:)
      context.schema.object_from_id(id, context)
    end

    field :nodes, [Types::NodeType, null: true], null: true do
      argument :ids, [ID], required: true
    end

    def nodes(ids:)
      ids.map { |id| context.schema.object_from_id(id, context) }
    end

    field :question, [Types::QuestionType], null: false
    def question
      Question.all
    end

    field :myResearch, [Types::ResearchType], null: false
    def myResearch
      validate_user()
      Research.where_group(context[:current_user].id)
    end

    field :openResearch, [Types::ResearchType], null: false
    def openResearch
      Research.where(status: 'open')
    end

    field :findResearch, Types::ResearchType, null: true do
      argument :id, ID, required: true
    end

    def findResearch(id:)
      Research.where(status: 'closed').find_by(id: id)
    end

    field :closedResearch, [Types::ResearchType], null: false
    def closedResearch
      Research.where(status: 'closed')
    end

    field :researchResults, Types::ResearchResultType, null: true do
      argument :research_id, ID, required: true
    end

    def researchResults(research_id:)
      research = Research.find_by(id: research_id)

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

    field :test_field, String, null: false
    def test_field
      "Hello World!"
    end
  end
end
