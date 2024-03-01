require 'rails_helper'

RSpec.describe Question, type: :model do
  it 'is valid with valid attributes' do
    question = create(:question)
    research = create(:research)
    question = build(:question, type_question: question.type_question, options_answer: question.options_answer ,research_id: research.id)
    expect(question).to be_valid
  end

  it "is not valid without a research_id" do
    question = FactoryBot.build(:question, research_id: nil)
    expect(question).to_not be_valid
  end

  it "is not valid without a type_question" do
    question = FactoryBot.build(:question, type_question: nil)
    expect(question).to_not be_valid
  end

  it "is not valid without a options_answer" do
    question = FactoryBot.build(:question, options_answer: nil)
    expect(question).to_not be_valid
  end
end
