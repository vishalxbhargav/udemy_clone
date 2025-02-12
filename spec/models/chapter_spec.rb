require 'rails_helper'

RSpec.describe Chapter, type: :model do
  it{should belong_to(:course)}
  it{should validate_presence_of(:video)}
  it{should validate_presence_of(:video)}
  it { is_expected.to have_one_attached(:video) }
  it{is_expected.to have_many_attached(:docs)}


  describe "validation" do
    let(:user){FactoryBot.create(:user)}
    let(:category){FactoryBot.create(:category)}
    let(:course){Course.create!(title:"testing tile for this course now on",description:"testing tile for this course now on",instructor_id:user.id,category_id:category.id,price:4444,thumbnail:File.open("#{Rails.root}/public/icon.png"))}
    let(:chapter){course.chapters.create(title:"introduction for course",video:File.open("#{Rails.root}/public/sample.mp4"),docs:[File.open("#{Rails.root}/public/notes.pdf")])}

    it "validate video" do
      chapter.valid?
    end
  end

  describe "validation when video content type invalid" do
    let(:user){FactoryBot.create(:user)}
    let(:category){FactoryBot.create(:category)}
    let(:course){Course.create!(title:"testing tile for this course now on",description:"testing tile for this course now on",instructor_id:user.id,category_id:category.id,price:4444,thumbnail:File.open("#{Rails.root}/public/icon.png"))}
    let(:chapter){course.chapters.create(title:"introduction for course",video:File.open("#{Rails.root}/public/icon.png"),docs:[File.open("#{Rails.root}/public/notes.pdf")])}

    it "validate video" do
      expect(chapter).to be_invalid
      expect(chapter.errors[:video]).to include("has an invalid content type (authorized content types are MKV, MP4, AVI, QT)")
    end
  end

  describe "validation when docs content type invalid" do
    let(:user){FactoryBot.create(:user)}
    let(:category){FactoryBot.create(:category)}
    let(:course){Course.create!(title:"testing tile for this course now on",description:"testing tile for this course now on",instructor_id:user.id,category_id:category.id,price:4444,thumbnail:File.open("#{Rails.root}/public/icon.png"))}
    let(:chapter){course.chapters.create(title:"introduction for course",video:File.open("#{Rails.root}/public/sample.mp4"),docs:[File.open("#{Rails.root}/public/icon.png")])}

    it "validate video" do
      expect(chapter).to be_invalid
      expect(chapter.errors[:docs]).to include("has an invalid content type (authorized content type is PDF)")
    end
  end

  describe "validation when docs content type mixed of invalid and valid" do
    let(:user){FactoryBot.create(:user)}
    let(:category){FactoryBot.create(:category)}
    let(:course){Course.create!(title:"testing tile for this course now on",description:"testing tile for this course now on",instructor_id:user.id,category_id:category.id,price:4444,thumbnail:File.open("#{Rails.root}/public/icon.png"))}
    let(:chapter){course.chapters.create(title:"introduction for course",video:File.open("#{Rails.root}/public/sample.mp4"),docs:[File.open("#{Rails.root}/public/icon.png"),File.open("#{Rails.root}/public/notes.pdf")])}

    it "validate video" do
      expect(chapter).to be_invalid
      expect(chapter.errors[:docs]).to include("has an invalid content type (authorized content type is PDF)")
    end
  end


  describe "custom method" do
    it "get prgress for chapter" do
      user=FactoryBot.create(:user)
      category=FactoryBot.create(:category)

      course=Course.create!(title:"testing tile for this course now on",description:"testing tile for this course now on",instructor_id:user.id,category_id:category.id,price:4444,thumbnail:File.open("#{Rails.root}/public/icon.png"))

      chapter=course.chapters.create!(title:"introduction for course",video:File.open("#{Rails.root}/public/sample.mp4"),docs:[File.open("#{Rails.root}/public/notes.pdf")])

      enrollment=Enrollment.create!(course_id:course.id,user_id:user.id)
      progres=Progre.create(enrollment_id:enrollment.id,chapter_id:chapter.id,completed:true)
      expect(chapter.get_progres(user)).to eq(progres)
    end
  end
end
