require 'rails_helper'

RSpec.describe PostsController, type: :controller do

  let(:user) { FactoryGirl.create(:user) }
  let(:guest_user) { FactoryGirl.create(:user) }
  let(:blog_post) { FactoryGirl.create(:post, user_id: user.id) }
  
  describe "GET #edit" do
    describe "when current user is not present" do
      it "returns message to login access as a flash message" do
        get :edit
        
        expect(response).to have_http_status(302)
        expect(flash[:alert]).to eq(I18n.t('unauthorized.login'))
      end
    end

    describe "when current user present" do
      it "returns http success" do
        sign_in user
        get :edit, params: {id: blog_post.id}
        
        expect(response).to have_http_status(:success)
      end
    end

    describe "when current user present and post does not belongs to user" do
      it "returns unauthorized access flash message" do
        sign_in guest_user
        get :edit, params: {id: blog_post.id}
        
        expect(response).to have_http_status(302)
        expect(flash[:alert]).to eq(I18n.t('unauthorized.default'))
      end
    end
  end

  describe "GET #new" do
    describe "when current user is not present" do
      it "returns message to login access as a flash message" do
        get :new
        
        expect(response).to have_http_status(302)
        expect(flash[:alert]).to eq(I18n.t('unauthorized.login'))
      end
    end
    
    describe "when current user present" do
      it "returns http success" do
        sign_in user
        get :new
        
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, params: {id: blog_post.id}
      
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    describe "when current user is not present" do
      it "returns message to login access as a flash message" do
        post :create, {}
        
        expect(response).to have_http_status(302)
        expect(flash[:alert]).to eq(I18n.t('unauthorized.login'))
      end
    end
    
    describe "when current user present" do
      it "returns http success and create post" do
        sign_in user
        params = {
          post: {
            title: Faker::Name.first_name,
            body: Faker::Lorem.sentence,
            image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/image.png'))),
            user_id: user.id
          }
        }
        my_post = Post.find_by_user_id(user.id)
        expect(my_post).to eq(nil)
       
        post :create, params: params

        my_post = Post.find_by_user_id(user.id)
        expect(my_post.present?).to eq(true)
      end
    end

    describe "handle exception" do
      it "returns exception in flash message" do
        sign_in user
        request.env['HTTP_REFERER'] = 'http://google.com'
        post :create, params: {}

        expect(response).to have_http_status(302)
        expect(flash[:alert].present?).to eq(true)
      end
    end
  end

  describe "PUT #update" do
    describe "when current user is not present" do
      it "returns message to login access as a flash message" do
        put :update, params: {id: Faker::Number.number(10)}
        
        expect(response).to have_http_status(302)
        expect(flash[:alert]).to eq(I18n.t('unauthorized.login'))
      end
    end
    
    describe "when current user present" do
      it "returns http success and update post" do
        sign_in user
        update_params = {
          id: blog_post.id,
          post: {
            title: Faker::Name.first_name,
            body: Faker::Lorem.sentence,
            image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/image.png'))),
            user_id: user.id
          }
        }
        put :update, params: update_params

        my_post = Post.find_by_user_id(user.id)
        expect(my_post.title).to eq(update_params[:post][:title])
        expect(my_post.body).to eq(update_params[:post][:body])
      end
    end

    describe "handle exception" do
      it "returns exception in flash message" do
        sign_in user
        request.env['HTTP_REFERER'] = 'http://google.com'
        put :update, params: {id: blog_post.id}

        expect(response).to have_http_status(302)
        expect(flash[:alert].present?).to eq(true)
      end
    end
  end

end
