require 'rails_helper'

RSpec.describe Enrollment, type: :model do
  describe "association" do
    it{ should have_many(:progres).dependent(:destroy)}
    it{ should belong_to(:user)}
    it{ should belong_to(:course)}
    it{ should define_enum_for(:status).with_values([:enrolled,:complete,:cencelled])}
  end

  describe "get users all completed chapter " do
    it "when all chapter completed" do
      user=FactoryBot.create(:user)
      category=FactoryBot.create(:category)

      course=Course.create!(title:"testing tile for this course now on",description:"testing tile for this course now on",instructor_id:user.id,category_id:category.id,price:4444,thumbnail:File.open("#{Rails.root}/public/icon.png"))

      chapter=course.chapters.create!(title:"introduction for course",video:File.open("#{Rails.root}/public/sample.mp4"),docs:[File.open("#{Rails.root}/public/notes.pdf")])
      chapter2=course.chapters.create!(title:"introduction for course",video:File.open("#{Rails.root}/public/sample.mp4"),docs:[File.open("#{Rails.root}/public/notes.pdf")])

      enrollment=Enrollment.create!(course_id:course.id,user_id:user.id)
      Progre.create(enrollment_id:enrollment.id,chapter_id:chapter.id,completed:true)
      Progre.create(enrollment_id:enrollment.id,chapter_id:chapter2.id,completed:true)

      expect(enrollment.get_completed_chapter).to eq(2)
    end

    it "when all chapter some of them completed" do
      user=FactoryBot.create(:user)
      category=FactoryBot.create(:category)

      course=Course.create!(title:"testing tile for this course now on",description:"testing tile for this course now on",instructor_id:user.id,category_id:category.id,price:4444,thumbnail:File.open("#{Rails.root}/public/icon.png"))

      chapter=course.chapters.create!(title:"introduction for course",video:File.open("#{Rails.root}/public/sample.mp4"),docs:[File.open("#{Rails.root}/public/notes.pdf")])
      chapter2=course.chapters.create!(title:"introduction for course",video:File.open("#{Rails.root}/public/sample.mp4"),docs:[File.open("#{Rails.root}/public/notes.pdf")])

      enrollment=Enrollment.create!(course_id:course.id,user_id:user.id)
      Progre.create(enrollment_id:enrollment.id,chapter_id:chapter.id,completed:true)
      Progre.create(enrollment_id:enrollment.id,chapter_id:chapter2.id)

      expect(enrollment.get_completed_chapter).to eq(1)
    end
  end

  describe "custom methodes" do
    it "is_user_enrolled in course" do
      user=FactoryBot.create(:user)
      category=FactoryBot.create(:category)

      course=Course.create!(title:"testing tile for this course now on",description:"testing tile for this course now on",instructor_id:user.id,category_id:category.id,price:4444,thumbnail:File.open("#{Rails.root}/public/icon.png"))

      Enrollment.create(course_id:course.id,user_id:user.id)
      enrollment=Enrollment.create(course_id:course.id,user_id:user.id)

      expect(enrollment).to be_invalid
      expect(enrollment.errors[:user_id]).to include("already enrolled")
    end
  end
end
