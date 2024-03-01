require 'rails_helper'

RSpec.describe Research, type: :model do
  it 'is valid with valid attributes' do
    research = create(:research)
    research = build(:research, title: research.title, status: research.status)

    expect(research).to be_valid
  end
  it 'is not valid without a title' do
    research = create(:research)
    research = build(:research, title: nil, status: research.status)
    expect(research).to_not be_valid
  end
  it 'is not valid without a status' do
    research = create(:research)
    research = build(:research, title: research.title, status: nil)
    expect(research).to_not be_valid
  end

end
