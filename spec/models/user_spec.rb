require 'rails_helper'

RSpec.describe User, type: :model do
  context 'When creating User' do
    let(:user) { build :user}
    it 'should be valid user with all attributes' do
      user.valid? == true
    end
  end
end
