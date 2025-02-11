require 'rails_helper'

RSpec.describe User, type: :model do
    describe 'association' do
      it{ should have_many(:courses)}
      it{ should have_many(:enrollments)}
      it{ should have_many(:enrolled_courses).through(:enrollments)}
      it{ should have_many(:orders)}
      it{ should have_many(:notifications)}
      it{ should have_many(:questions)}
      it{ should have_many(:answers)}
      it{ should have_many(:comments)}
    end
    describe 'validations' do

      it { should validate_presence_of(:email) }
      it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }
      it { should validate_presence_of(:first_name)}
      it { should validate_presence_of(:username) }
      it { should validate_presence_of(:last_name)}
      it { should define_enum_for(:role).with_values([:User,:Instructor,:Admin])}

      it "full name when data valid" do
        user=FactoryBot.build(:user)
        expect(user.full_name).to eq(user.first_name+" "+user.last_name)
      end

      it "full name when data valid" do
        user=FactoryBot.build(:user)
        expect(user.full_name).not_to eq(user.first_name+" v "+user.last_name)
      end
    end

    describe 'methodes' do
      subject{FactoryBot.build(:user)}
      it "total_earning" do
        p subject.courses
      end

      it "total_earning_for_last_month" do
        p subject.courses
      end

      it "unread_notification" do
        p subject.notifications
      end

    end
end
