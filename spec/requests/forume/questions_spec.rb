require 'rails_helper'

RSpec.describe "Forume::Questions", type: :request do
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
  let!(:forume){Forume.create(course_id:course.id)}
  let!(:enrollment){Enrollment.create(user_id:user.id,course_id:course.id)}
  let!(:question){Question.create(
    title: Faker::JapaneseMedia::OnePiece.character,
    description: Faker::JapaneseMedia::OnePiece.quote,
    user_id: user.id,
    forume_id: forume.id
  )}

  #when user is not instructor
  let!(:user1){ FactoryBot.create(:user)}
  let!(:enrollment1){Enrollment.create(user_id:user1.id,course_id:course.id)}
  let!(:question1){Question.create(
    title: Faker::JapaneseMedia::OnePiece.character,
    description: Faker::JapaneseMedia::OnePiece.quote,
    user_id: user1.id,
    forume_id: forume.id
  )}

  before do
    sign_in user, scope: :user
  end

  describe "GET /show" do

    describe "when user authenticate" do
      it "but not enrolled in course" do
        demo_user=FactoryBot.create(:user)
        sign_in demo_user,scope: :user
        get "/forume/questions/#{question.id}"
        expect(response.status).to eq(302)
        expect(response).to redirect_to root_path
      end

      it "and enrolled in course" do
        get "/forume/questions/#{question.id}"
        expect(response.status).to eq(200)
      end
    end

    # it "when user not authenticated" do
    #   sign_out user
    #   get "/forume/questions/#{question.id}"
    #   expect(response.status).to eq(302)
    #   expect(response).to redirect_to root_path
    # end
  end

  describe "GET /edit" do
    describe "when user authenticated" do
      describe "as instructor" do
        it "access edit question when instructor is creator" do
          get "/forume/questions/#{question.id}/edit"
          expect(response.status).to eq(200)  
        end

        it "access edit question when instructor is not creator" do
          demo_user=FactoryBot.create(:user,:Instructor)
          sign_in demo_user,scope: :user
          get "/forume/questions/#{question.id}/edit"
          expect(response.status).to eq(302)
          redirect_to root_path   
        end
      end

      describe "as student" do
        it "access edit question when user enrolled in course" do 
          sign_in user1,scope: :user
          get "/forume/questions/#{question1.id}/edit"
          expect(response.status).to eq(200)
        end

        it "access edit question when user not enrolled in course" do 
          demo_user=FactoryBot.create(:user)
          sign_in demo_user,scope: :user
          get "/forume/questions/#{question1.id}/edit"
          expect(response.status).to eq(302)
          expect(response).to redirect_to root_path
        end
      end
    end

    it  "when user is not authenticated "do
      sign_out user
      get "/forume/questions/#{question.id}/edit"
      expect(response.status).to eq(302)
      expect(response).to redirect_to root_path
    end
  end

  describe "POST /create" do
    let!(:valid_params) do {
      question:{
        title: "tesing title for question",
        description: "this is description for question"
      }
    }
    end
    let!(:invalid_params)do{
      question:{
        description: "Faker::JapaneseMedia::OnePiece.quote"
      }
    }
    end

    describe "when user authenticate" do

      describe "as instructor" do
        describe "and he is creator" do
          describe "when params valid" do
           
            it "create question" do 
              post "/forume/forumes/#{forume.id}/questions",params: valid_params
              expect(response.status).to eq(200)
            end
          end

          describe "when params invalid" do
            it "create question" do
              post "/forume/forumes/#{forume.id}/questions",params: invalid_params
              expect(response.status).to eq(404)
            end
          end
        end
      end
      
      describe "as student" do
        describe "enrolled in course" do
          describe "when params valid" do
            it "create question" do 
              sign_in user1,scope: :user
              post "/forume/forumes/#{forume.id}/questions",params: valid_params
              expect(response.status).to eq(200)
            end
          end

          describe "when params invalid" do
            it "create question" do
              sign_in user1,scope: :user
              post "/forume/forumes/#{forume.id}/questions",params: invalid_params
              expect(response.status).to eq(404)
            end
          end
        end
      end
    end

    it "when user not authenticate" do
      sign_out user
      post "/forume/forumes/#{forume.id}/questions",params: valid_params
      expect(response.status).to eq(302)
      expect(response).to redirect_to root_path
    end
  end

  describe "PUT /update" do
    let!(:valid_params)do{
      question:{
        title:"updated title",
        description: "updated description"
      }
    }
    end
    let!(:invalid_params)do{
      question:{
        title:"updated title",
        description: "updated description"
      }
    }
    end
    describe "when user athenticate" do
      it "when instructor is creator of forume with full params" do
        put "/forume/questions/#{question.id}",params:valid_params
        expect(response.status).to eq(302)
        expect(response).to redirect_to forume_forume_path(question.forume)
      end

      it "when instructor is creator of forume partial params" do
        put "/forume/questions/#{question.id}",params:invalid_params
        expect(response.status).to eq(302)
        expect(response).to redirect_to forume_forume_path(question.forume)
      end
      it "when instructor is not belongs to the forume" do
        demo_user=FactoryBot.create(:user,Instructor)
        sign_in demo_user,scope: :user
        put "/forume/questions/#{question.id}",params:invalid_params
        expect(response.status).to eq(302)
        expect(response).to redirect_to root_path
      end
    end

    it "when user not authenticate" do
        sign_out user
        put "/forume/questions/#{question.id}",params:valid_params
        expect(response.status).to eq(302)
        expect(response).to redirect_to root_path
      end
  end
  
  describe "DELETE /destroy" do
    describe "when user is authenticated" do
      
    end
  end
end
