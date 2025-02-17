require 'rails_helper'

RSpec.describe "Forume::Fourumes", type: :request do
  let!(:image) { fixture_file_upload(Rails.root.join('spec/fixtures/files/test.jpg'), 'image/png') }
  let!(:category){FactoryBot.create(:category)}
  #when user is instructor
  let!(:user){FactoryBot.create(:user,:Instructor)}
  let!(:course){
    Course.create!(
      title:"testing tile for this course now on",
      description:"testing tile for this course now on",
      instructor_id:user.id,
      category_id:category.id,
      price:4444,
      thumbnail:image
    )
  }
  let(:forume){Forume.create(course_id:course.id)}
  let(:enrollment){Enrollment.create(user_id:user.id,course_id:course.id)}

  #when user is not instructor
  let!(:user1){ FactoryBot.create(:user)}
  let!(:course1){
    Course.create!(
      title:"testing tile for this course now on",
      description:"testing tile for this course now on",
      instructor_id:user1.id,
      category_id:category.id,
      price:4444,
      thumbnail:image
    )
  }
  before(:each) do
    sign_in user, scope: :user
  end

  describe "GET /index" do
    
    it "user must be authenticated" do
      get "/forume/forumes"
      expect(response.status).to eq(200)
    end

      
    it "when user not authenticated" do
      sign_out user
      get "/forume/forumes"
      expect(response.status).to eq(302)
      expect(response).to redirect_to root_path
    end
  end

  describe "GET /show" do
    it "when user not authenticated" do
      sign_out user
      get "/forume/forumes"
      expect(response.status).to eq(302)
      expect(response).to redirect_to root_path
    end
    it "when user enrolled that course which belongs to forume" do
      get "/forume/forumes/#{forume.id}"
      expect(response.status).to eq(200)
    end

    it "when user is not enrolled that course which belongs to forume" do
      sign_in user1,scope: :user
      get "/forume/forumes/#{forume.id}"
      expect(response.status).to eq(302)
      expect(response).to redirect_to root_path
    end
  end
end
