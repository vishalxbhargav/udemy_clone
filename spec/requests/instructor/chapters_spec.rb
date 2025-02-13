require 'rails_helper'

RSpec.describe "Instructor::Chapters", type: :request do
  let(:user){FactoryBot.create(:user)}
  before do
    sign_in user, scope: :user
  end

  describe "GET /new" do
    it "render create chapter form" do
      get "/instructor/course/4/chapter/new"
      debugger
      expect(response.status).to eq(200)
    end
  end
end
