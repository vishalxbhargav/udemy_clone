require 'rails_helper'

RSpec.describe "Instructor::Courses", type: :request do 
  let(:user){FactoryBot.create(:user)}
  before do
    sign_in user
  end
  describe "GET /new" do
    let(:user){FactoryBot.create(:user)}
   
    it "course form page" do
      debugger
      get "/instructor/courses/new"
      expect(response.status).to eq(200)
    end
  end
end
