require 'rails_helper'

RSpec.describe "Instructor::Courses", type: :request do 
  let!(:user){FactoryBot.create(:user,:Instructor)}
  let!(:image) { fixture_file_upload(Rails.root.join('spec/fixtures/files/test.jpg'), 'image/png') }
    let!(:category){FactoryBot.create(:category)}
  before do
    sign_in user, scope: :user
  end
  describe "GET /new" do
    it "course form page when user is Instructor" do
      get "/instructor/courses/new"
      expect(response.status).to eq(200)
    end

    it "course form page when user is not Instructor" do
      user=FactoryBot.create(:user)
      sign_in user,scope: :user
      get "/instructor/courses/new"
      expect(response.status).to eq(302)
    end
  end

  describe "GET /show" do
    let(:category){FactoryBot.create(:category)}

    let(:course){
      Course.create!(
        title:"testing tile for this course now on",
        description:"testing tile for this course now on",
        instructor_id:user.id,
        category_id:category.id,
        price:4444,
        thumbnail:File.open("#{Rails.root}/public/icon.png")
      )
    }
    
    let!(:forume){Forume.create(course_id:course.id)}

    it "course when user not sign_in" do
      sign_out user
      get "/instructor/courses/#{course.id}"
      expect(response.status).to eq(302)
    end

    it "course when user is Instructor" do
      get "/instructor/courses/#{course.id}"
      expect(response.status).to eq(200)
    end

    it "course when user is not Instructor" do
      user=FactoryBot.create(:user)
      sign_in user,scope: :user

      get "/instructor/courses/#{course.id}"
      expect(response.status).to eq(302)
    end

    it "course when user is  Instructor but course does't belong to him" do
      user1=FactoryBot.create(:user)
      sign_in user1,scope: :user

      get "/instructor/courses/#{course.id}"
      expect(response.status).to eq(302)
    end
  end

  describe "POST /create" do
    

    let!(:valid_params) do 
      { course: { 
          title: "testing title", 
          description: "testing desc", 
          instructor_id: user.id, 
          category_id: category.id, 
          price: 4000, 
          thumbnail:image 
      }}
    end

    let!(:short_title_params) do 
      { course: { 
          title: "title", 
          description: "testing desc", 
          instructor_id: user.id, 
          category_id: category.id, 
          price: 4000, 
          thumbnail:image 
      }}
    end

    let(:course){
      Course.create!(title:"testing tile for this course now on",description:"testing tile for this course now on",
      instructor_id:user.id,
      category_id:category.id,
      price:4444,
      thumbnail: File.open("#{Rails.root}/public/icon.png")
      )
    }
    

    # it "user must be login as instructor" do
    #   sign_in user,scope: :user
    #   debugger
    #   expect(user_signed_in?).to_true
    # end

    it "create course when params valid" do
  
      post "/instructor/courses", params: valid_params
      expect(response).to redirect_to instructor_path
    end

    describe "when course params invalid" do
      it "title length less then 10" do

        post "/instructor/courses", params: short_title_params
        expect(response).to redirect_to new_instructor_course_path(Course.last)
      end

      it "title length less then 10 for model" do

        course=Course.create(short_title_params[:course])
        expect(course).to be_invalid
        expect(course.errors[:title]).to include("is too short (minimum is 10 characters)");
      end
    end
  end

  describe "GET /edit" do
    let(:course){
      Course.create!(
        title:"testing tile for this course now on",
        description:"testing tile for this course now on",
        instructor_id:user.id,
        category_id:category.id,
        price:4444,
        thumbnail:image
      )
    }
    describe "when user is instructor" do
      it "and course belongs to user" do
        get "/instructor/courses/#{course.id}/edit"
        expect(response.status).to eq(200)
      end

      it "and course doesn't belongs to user" do
        user1=FactoryBot.create(:user,:Instructor)
        course1=
          Course.create!(
            title:"testing tile for this course now on",
            description:"testing tile for this course now on",
            instructor_id:user1.id,
            category_id:category.id,
            price:4444,
            thumbnail:image
          )
        get "/instructor/courses/#{course1.id}/edit"
        expect(response).to redirect_to root_path
      end
    end

    it "when user is not instructor" do
      user1=FactoryBot.create(:user)
      course1=
        Course.create!(
          title:"testing tile for this course now on",
          description:"testing tile for this course now on",
          instructor_id:user1.id,
          category_id:category.id,
          price:4444,
          thumbnail:image
        )
      get "/instructor/courses/#{course1.id}/edit"
      expect(response).to redirect_to root_path
    end

    it "course is not found" do
      get "/instructor/courses/1/edit"
      expect(response.status).to eq(404)
    end
  end

  describe "PUT /update" do
    let(:course){
      Course.create!(
        title:"testing tile for this course now on",
        description:"testing tile for this course now on",
        instructor_id:user.id,
        category_id:category.id,
        price:4444,
        thumbnail:image
      )
    }

    let!(:updated_params) do 
      { course: { 
          title: "updated title", 
          description: "updated description", 
          instructor_id: user.id, 
          category_id: category.id, 
          price: 4000, 
          thumbnail:image 
      }
    }
    end


    let!(:title_update_params) do 
      { course: { 
          title: "updated title"
      }
    }
    end

    let!(:description_update_params) do 
      { course: { 
          title: "updated description"
      }
    }
    end

    describe "when user is instructor " do
      describe "instructor contains course" do
        it "course update when all attribute " do
          put "/instructor/courses/#{course.id}",params: updated_params
          expect(response).to redirect_to instructor_path
        end

        it "course update when all attribute " do
          put "/instructor/courses/#{course.id}",params: updated_params
          expect(response).to redirect_to instructor_path
        end

        it "update title" do
          put "/instructor/course/#{course.id}", params: title_update_params
        end
      end
      describe "instructor doesn't contain course" do
        user1=FactoryBot.create(:user,:Instructor)
        let(:course1){
          Course.create!(
            title:"testing tile for this course now on",
            description:"testing tile for this course now on",
            instructor_id:user1.id,
            category_id:category.id,
            price:4444,
            thumbnail:image
          )
        }
        it "update course" do
          put "/instructor/course/#{course1.id}", params: updated_params
          expect(response.status).to eq(404)
        end
      end
    end
    describe "when user is not instructor" do
      let(:user2){FactoryBot.create(:user)}
      let(:course){
        Course.create!(
          title:"testing tile for this course now on",
          description:"testing tile for this course now on",
          instructor_id:user2.id,
          category_id:category.id,
          price:4444,
          thumbnail:image
        )
      }
      it "" do
        user1=FactoryBot.create(:user)
        sign_in user1, scope: :user
        put "/instructor/course/#{course.id}",params: updated_params
        expect(response.status).to eq(404)
      end
    end
  end

  describe "PUT /destroy" do
    let(:course){
      Course.create!(
        title:"testing tile for this course now on",
        description:"testing tile for this course now on",
        instructor_id:user.id,
        category_id:category.id,
        price:4444,
        thumbnail:image
      )
    }
    describe "when user is instructor" do

    end

    describe "when user is not instructor" do
      
    end
  end
end
