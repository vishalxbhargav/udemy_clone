require 'rails_helper'

RSpec.describe "Instructor::Chapters", type: :request do

  let!(:image) { fixture_file_upload(Rails.root.join('spec/fixtures/files/test.jpg'), 'image/png') }
  let!(:video) { fixture_file_upload(Rails.root.join('spec/fixtures/files/test.mp4'), 'video/mp4') }
  let!(:notes) { fixture_file_upload(Rails.root.join('spec/fixtures/files/test.pdf'), 'pdf/text') }
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


  before do
    sign_in user, scope: :user
  end

  describe "GET /new" do
    describe "When user is instructor" do
      it "render create chapter form" do
        get "/instructor/courses/#{course.id}/chapters/new"
        expect(response.status).to eq(200)
      end
    end

    describe "When user is not instructor" do
      it "render create chapter form" do
        user2=FactoryBot.create(:user)
        sign_in user2,scope: :user
        get "/instructor/courses/#{course.id}/chapters/new"
        expect(response.body).to eq("unauthorized access")
      end
    end
  end

  describe "GET /show" do
    describe "When user is instructor" do

      describe "doesn't contain chapter" do
        user1=FactoryBot.create(:user)
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
        it "access different user's chapter" do
          sign_in user1,scope: :user
          get "/instructor/chapters/#{chapter.id}"
          expect(response).to redirect_to root_path
        end
      end

      it "render create chapter form" do
        get "/instructor/chapters/#{chapter.id}"
        expect(response.status).to eq(200)
      end

    end

    describe "When user is not instructor" do
      it "render create chapter form" do
        user2=FactoryBot.create(:user)
        sign_in user2,scope: :user
        get "/instructor/chapters/#{chapter.id}"
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "GET /edit" do

    describe "when user authenticated" do

      describe "but not a instructor" do

        it "get edit chapter route" do
          sign_in :user,scope: :user1

          get "/instructor/chapters/#{chapter1.id}"
          expect(response.status).to eq(302)
          expect(response).to redirect_to root_path
        end
      end

      describe "as instructor" do
        it "get edit route" do
          get "/instructor/chapters/#{chapter.id}/edit"
          expect(response.status).to eq(200)
        end

        it "chapter doesn't belongs to instructor" do
          get "/instructor/chapters/#{chapter1.id}/edit"
          expect(response.status).to eq(302)
        end
      end

    end

    # it "when user isn't authenticated" do
    #   debugger
    #   sign_out "user/sign_out/#{user.id}"
    #   get "/instructor/chapters/#{chapter.id}/edit"
    #   debugger
    #   expect(response).to redirect_to root_path
    #   expect(response.status).to eq(302)
    # end

  end

  describe "Post /create" do
    let!(:valid_params) do 
      { chapter: { 
          title: "testing title", 
          video: video, 
          docs: [notes]
      }
    }
    end

    let!(:invalid_params) do 
      { chapter: { 
          title: "testing title", 
          video: notes, 
          docs: [video]
      }
    }
    end

    describe "when user authenticated" do
      describe "as instructor" do
        describe "and course belongs to user" do
          describe "when valid params" do
            it "create chapter when course id valid" do
              post "/instructor/courses/#{course.id}/chapters",params: valid_params
              expect(response.status).to eq(302)
              expect(response).to redirect_to instructor_course_path(course)
            end

            it "create chapter when course id invalid" do
              post "/instructor/courses/5/chapters",params: valid_params
              expect(response.status).to eq(404)
            end
          end

          describe "when params invalid" do
            it "create chapter when course id valid" do
              post "/instructor/courses/#{course.id}/chapters",params: invalid_params
              expect(response.status).to eq(302)
              expect(response).to redirect_to new_instructor_course_chapter_path(course)
            end
            it "create chapter when course id invalid" do
              post "/instructor/courses/5/chapters",params: invalid_params
              expect(response.status).to eq(404)
            end
          end
        end

        describe "and course doesn't belongs to user" do
          it "create chapter when chapter" do
            post "/instructor/courses/#{course1.id}/chapters",params: valid_params
            expect(response.status).to eq(401)
            expect(response.body).to eq("unauthorized access")
          end
        end
      end
    end
  end

  describe "PUT /update" do
    let!(:valid_params) do 
      { chapter: { 
          title: "testing title", 
          video: video, 
          docs: [notes]
      }
    }
    end

    let!(:invalid_params) do 
      { chapter: { 
          title: "testing title", 
          video: notes, 
          docs: [video]
      }
    }
    end
    describe "user authenticated" do
      describe "as instructor" do
        describe "contains course" do
          describe " valid params" do
            it "update chapter" do
              put "/instructor/chapters/#{chapter.id}",params: valid_params
              expect(response.status).to eq(302)
              expect(response).to redirect_to instructor_course_path(chapter)
            end
          end
          describe " invalid params" do
            it "update chapter" do
              put "/instructor/chapters/#{chapter.id}",params: invalid_params
              expect(response.status).to eq(302)
              expect(response).to redirect_to edit_instructor_chapter_path(chapter)
            end
          end
        end
        describe "doesn't contains course" do
          it "update chapter" do
            put "/instructor/chapters/#{chapter1.id}",params: valid_params
            expect(response.status).to eq(302)
            expect(response).to redirect_to root_path
          end
        end
      end
    end
  end

  # describe "DELETE /destroy" do
  #   describe "user authenticated" do
  #     describe "as instructor" do
  #       describe "user contain chapter" do
  #         it "delete chapter" do
  #           debugger
  #           delete "/instructor/chapters/#{chapter.id}"
  #           expect(response.status).to eq(302)
  #           expect(response).to redirect_to instructor_course_path(course)
  #         end
  #       end
  #       describe "doesn't contain chapter" do
  #         it "delete chapter" do
  #           delete "/instructor/chapters/#{chapter.id}"
  #           expect(response.status).to eq(302)
  #           expect(response).to redirect_to root_path
  #         end
  #       end
  #     end
  #     describe "as User" do

  #     end
  #   end
  # end
end
