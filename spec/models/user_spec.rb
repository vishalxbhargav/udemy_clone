require 'rails_helper'

RSpec.describe User, type: :model do
    describe 'association' do
      it{ should have_many(:courses)}
      it{ should have_many(:enrollments)}
      it{ should have_many(:enrolled_courses).through(:enrollments)}
    end
    describe 'validations' do

      it { should validate_presence_of(:email) }
      it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }
      it { should validate_presence_of(:first_name)}
      it { should validate_presence_of(:username) }
      it { should validate_presence_of(:last_name)}

      it "full name when data valid" do
        user=FactoryBot.build(:user)
        expect(user.full_name).to eq(user.first_name+" "+user.last_name)
      end

      it "full name when data valid" do
        user=FactoryBot.build(:user)
        expect(user.full_name).not_to eq(user.first_name+" v "+user.last_name)
      end
    end
end
