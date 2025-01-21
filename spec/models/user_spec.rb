require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe 'validations' do
    let(user){FactoryBot.build(:user)}
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:first_name)}
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:last_name)}
  end
end
