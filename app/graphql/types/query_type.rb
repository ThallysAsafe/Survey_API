# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :node, Types::NodeType, null: true, description: "Fetches an object given its ID." do
      argument :id, ID, required: true, description: "ID of the object."
    end

    def node(id:)
      context.schema.object_from_id(id, context)
    end

    field :nodes, [Types::NodeType, null: true], null: true, description: "Fetches a list of objects given a list of IDs." do
      argument :ids, [ID], required: true, description: "IDs of the objects."
    end

    def nodes(ids:)
      ids.map { |id| context.schema.object_from_id(id, context) }
    end

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    # TODO: remove me
    field :question, [Types::QuestionType], null: false
    def question
      Question.all
    end

    field :research, [Types::ResearchType], null: false
    def research
      Research.preload(:questions)
    end
    field :openresearch, [Types::ResearchType], null: false
    def openresearch
      Research.where(status: 'open')
    end
    field :closedresearch, [Types::ResearchType], null: false
    def closedresearch
      Research.where(status: 'closed')
    end

    field :test_field, String, null: false,
      description: "An example field added by the generator"
    def test_field
      "Hello World!"
    end
  end
end
