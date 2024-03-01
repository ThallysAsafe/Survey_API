require 'rails_helper'

RSpec.describe Answer, type: :model do
  it 'is valid with valid attributes' do
    question = create(:question)
    research = create(:research)
    answer = build(:answer, question_id: question.id, research_id: question.research_id)

    expect(answer).to be_valid
  end
end
