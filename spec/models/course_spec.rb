require 'rails_helper'

RSpec.describe Course, type: :model do
  describe "association" do
    it { should belong_to(:category).class_name('Category') }
    it { should belong_to(:user) }
    it { should have_many(:chapters)}
    it { should have_many(:enrollments)}
  end
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:title)}
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:thumbnail)}
  end
end
