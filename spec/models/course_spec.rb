require 'rails_helper'

RSpec.describe Course, type: :model do
  describe "association" do
    it { should belong_to(:category).class_name('Category') }
    it { should belong_to(:user) }
    it { should have_many(:chapters)}
    it { should have_many(:enrollments)}
    it { should have_many(:enrolled_users).through(:enrollments)}
    it { is_expected.to have_rich_text(:course_content)}
    it { is_expected.to have_one_attached(:thumbnail) }
    it { should have_many(:orders)}
    it { should have_one(:forume)}
    it { should have_one(:verifycation)}

  end
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:title)}
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:thumbnail)}
  end

  describe "create course" do
    let(:user) { FactoryBot.create(:user) }
    let(:category) {FactoryBot.create(:category)}
    it 'when all the attribute presents' do
      course=Course.create!(title:"testing tile for this course now on",description:"testing tile for this course now on",instructor_id:user.id,category_id:category.id,price:4444,thumbnail:File.open("#{Rails.root}/public/icon.png"))
      course.valid?
    end
  end

  describe 'scopes' do

    let(:user) { FactoryBot.create(:user) }
    let(:category) {FactoryBot.create(:category)}

    it "last month created course" do

      course=Course.create!(title:"testing tile for this course now on",description:"testing tile for this course now on",instructor_id:user.id,category_id:category.id,price:4444,thumbnail:File.open("#{Rails.root}/public/icon.png"),created_at: "2025-01-12 08:01:19.210574000 +0000")

      expect(Course.last_month).to eq([course])

    end

    it "there is no course created by last month" do

      course=Course.create!(title:"testing tile for this course now on",description:"testing tile for this course now on",instructor_id:user.id,category_id:category.id,price:4444,thumbnail:File.open("#{Rails.root}/public/icon.png"))

      expect(Course.last_month).to eq([])

    end
  end

  describe "custom methodes" do
    let!(:user) { FactoryBot.create(:user) }
    let!(:category) {FactoryBot.create(:category)}

    it "total earning by course when data valid" do
      course=Course.create!(title:"testing tile for this course now on",description:"testing tile for this course now on",instructor_id:user.id,category_id:category.id,price:4444,thumbnail:File.open("#{Rails.root}/public/icon.png"))
      user1=FactoryBot.create(:user)
      user2=FactoryBot.create(:user)
      order=Order.create(user_id:user.id,course_id:course.id,transaction_id:"122341233243",amount:5000)
      order=Order.create(user_id:user2.id,course_id:course.id,transaction_id:"122341233243",amount:5000)
      expect(course.total_earning_by_course).to eq(10000)
    end

    it "total earning by course when data invalid" do
      course=Course.create!(title:"testing tile for this course now on",description:"testing tile for this course now on",instructor_id:user.id,category_id:category.id,price:4444,thumbnail:File.open("#{Rails.root}/public/icon.png"))
      user1=FactoryBot.create(:user)
      user2=FactoryBot.create(:user)
      order=Order.create(user_id:user1.id,course_id:course.id,transaction_id:"122341233243",amount:5000)
      order=Order.create(user_id:user2.id,course_id:course.id,transaction_id:"122341233243",amount:5000)
      expect(course.total_earning_by_course).not_to eq(20000)
    end
  end

  it "total earning in last month by course when data valid" do
    
    user=FactoryBot.create(:user)
    category=FactoryBot.create(:category)
    
    course=Course.create!(title:"testing tile for this course now on",description:"testing tile for this course now on",instructor_id:user.id,category_id:category.id,price:4444,thumbnail:File.open("#{Rails.root}/public/icon.png"))
    
    user1=FactoryBot.create(:user)
    user2=FactoryBot.create(:user)
    
    Order.create(user_id:user1.id,course_id:course.id,transaction_id:"122341233243",amount:5000, created_at: "2025-01-12 08:20:47.584514000 +0000",
    )
    
    Order.create(user_id:user2.id,course_id:course.id,transaction_id:"122341233243",amount:5000,
    )
    
    expect(course.last_month_earning_by_course).to eq(5000)
  end

  it "total earning in last month by course when data invalid" do
    user=FactoryBot.create(:user)
    category=FactoryBot.create(:category)

    course=Course.create!(title:"testing tile for this course now on",description:"testing tile for this course now on",instructor_id:user.id,category_id:category.id,price:4444,thumbnail:File.open("#{Rails.root}/public/icon.png"))

    user1=FactoryBot.create(:user)
    user2=FactoryBot.create(:user)
    
    Order.create(user_id:user1.id,course_id:course.id,transaction_id:"122341233243",amount:5000, created_at: "2025-02-12 08:20:47.584514000 +0000",
    )
    
    Order.create(user_id:user2.id,course_id:course.id,transaction_id:"122341233243",amount:5000,
    )
    
    expect(course.last_month_earning_by_course).not_to eq(5000)
  end

  it "course completion when course has no chapter" do
    user=FactoryBot.create(:user)
    category=FactoryBot.create(:category)

    course=Course.create!(title:"testing tile for this course now on",description:"testing tile for this course now on",instructor_id:user.id,category_id:category.id,price:4444,thumbnail:File.open("#{Rails.root}/public/icon.png"))

    expect(course.completion(user)).to eq(0)
  end

  it "course completion when course contains chapter and chapter not completed" do
    user=FactoryBot.create(:user)
    category=FactoryBot.create(:category)

    course=Course.create!(title:"testing tile for this course now on",description:"testing tile for this course now on",instructor_id:user.id,category_id:category.id,price:4444,thumbnail:File.open("#{Rails.root}/public/icon.png"))

    chapter=course.chapters.create!(title:"introduction for course",video:File.open("#{Rails.root}/public/sample.mp4"),docs:[File.open("#{Rails.root}/public/notes.pdf")])

    enrollment=Enrollment.create!(course_id:course.id,user_id:user.id)
    progres=Progre.create(enrollment_id:enrollment.id,chapter_id:chapter.id)

    expect(course.completion(user)).to eq(0)
  end

  it "course completion when course contains chapter and chapter completed" do
    user=FactoryBot.create(:user)
    category=FactoryBot.create(:category)

    course=Course.create!(title:"testing tile for this course now on",description:"testing tile for this course now on",instructor_id:user.id,category_id:category.id,price:4444,thumbnail:File.open("#{Rails.root}/public/icon.png"))

    chapter=course.chapters.create!(title:"introduction for course",video:File.open("#{Rails.root}/public/sample.mp4"),docs:[File.open("#{Rails.root}/public/notes.pdf")])

    enrollment=Enrollment.create!(course_id:course.id,user_id:user.id)
    progres=Progre.create(enrollment_id:enrollment.id,chapter_id:chapter.id,completed:true)

    expect(course.completion(user)).to eq(100)
  end
  
end
