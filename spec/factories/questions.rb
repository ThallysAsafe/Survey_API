FactoryBot.define do
  factory :question do
    name { "Questão 1" }
    research_id { create(:research).id }
    type_question { %w[text checkbox radio].sample }

    options_answer do
      case type_question
      when "checkbox"
        ["Normal User","Best User","Vocations","Teste0","Teste"]
      when "text"
         %w[single-line mult-line].sample(1)
      when "radio"
        ["Unknown User","teste1","teste2","teste3","teste4"]
      end
    end
  end
end
