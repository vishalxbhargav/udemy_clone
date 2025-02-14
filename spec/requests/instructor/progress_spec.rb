require 'rails_helper'

RSpec.describe "Instructor::Progress", type: :request do
  let!(:image) { fixture_file_upload(Rails.root.join('spec/fixtures/files/test.jpg'), 'image/png') }
  let!(:video) { fixture_file_upload(Rails.root.join('spec/fixtures/files/test.mp4'), 'video/mp4') }
  let!(:notes) { fixture_file_upload(Rails.root.join('spec/fixtures/files/test.pdf'), 'pdf/text') }
  let!(:category){FactoryBot.create(:category)}

  #when user is instructor
  let!(:user){FactoryBot.create(:user)}
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
  let!(:chapter){
    Chapter.create!(
      title:"Tesing Title for chapter",
      video: video,
      docs: [notes],
      course_id: course.id
    )
  }

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
  let!(:chapter1){
    Chapter.create!(
      title:"Tesing Title for chapter",
      video: video,
      docs: [notes],
      course_id: course1.id
    )
  }
  let!(:enrollment){
    Enrollment.create!(user_id:user.id,course_id:course.id)
  }
  let!(:progress){
    Progre.create(chapter_id:chapter.id,enrollment_id:enrollment.id)
  }
  before do
    sign_in user, scope: :user
  end
  describe "POST /mark_as_complete" do
    describe "user authenticate" do
      it "mark as complete" do
        post "/instructor/mark_as_complete/#{chapter.id}"
        expect(response.status).to eq(200)
        expect(response.body).to eq("Status Change")
      end
    end
  end
end
