require 'rails_helper'

RSpec.describe "Home", type: :request do
  describe "GET /index" do
    it "home page" do
        get "/"
        expect(response.status).to eq(200)
    end
  end

  describe "GET /search" do
    let!(:user){FactoryBot.create(:user)}
    let!(:category){FactoryBot.create(:category)}
    let!(:course){Course.create!(title:"testing tile for this course now on",description:"testing tile for this course now on",instructor_id:user.id,category_id:category.id,price:4444,thumbnail:File.open("#{Rails.root}/public/icon.png"))}
    let!(:chapter){course.chapters.create(title:"introduction for course",video:File.open("#{Rails.root}/public/sample.mp4"),docs:[File.open("#{Rails.root}/public/notes.pdf")])}
    it "search course" do
        get "/search", params:{query:"vishal"}
        expect(response.status).to eq(200)
    end
  end
end
