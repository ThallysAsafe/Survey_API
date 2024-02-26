FactoryBot.define do
  factory :answer do
    transient do
      question { create(:question) }
    end
    research_id { question.research_id }
    question_id { question.id }
    user_id { create(:user).id }

    answer do
      case question.type_question
      when "checkbox"
        ["Normal User", "Best User", "Vocations", "Teste0", "Teste"].sample(rand(2..5))
      when "radio"
        ["Unknown User", "teste1", "teste2", "teste3", "teste4"].sample(1)
      when "text"
        case question.options_answer[0]
        when "mult-line"
          [Faker::Lorem.paragraph]
        when "single-line"
          [Faker::Lorem.sentence]
        end
      end
    end
  end
end
