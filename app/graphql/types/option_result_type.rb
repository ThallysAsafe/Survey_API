module Types
  class OptionResultType < Types::BaseObject
    field :option_title, String, null: false, description: "Title of the option"
    field :response_count, Int, null: false, description: "Number of responses for the option"
  end
end
