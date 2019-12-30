require 'rails_helper'

RSpec.describe CommentsController, type: :controller do

  let(:user) { FactoryGirl.create(:user) }
  let(:blog_post) { FactoryGirl.create(:post, user_id: user.id) }
  let(:comment) { FactoryGirl.create(:comment, user_id: user.id, post_id: blog_post.id) }

  describe "POST #create" do
    describe "when current user is not present" do
      it "returns message to login access as a flash message" do
        post :create, {}

        expect(response).to have_http_status(302)
        expect(flash[:alert]).to eq(I18n.t('unauthorized.login'))
      end
    end
    
    describe "when current user present" do
      it "returns http success and create comments on post" do
        sign_in user
        params = {
          post_id: blog_post.id, 
          body: Faker::Lorem.sentence,
          user_id: user.id
        }
        expect(blog_post.comments).to eq([])
       
        post :create, params: params

        expect(blog_post.reload.comments.present?).to eq(true)
        comment = blog_post.comments.first
        expect(comment[:body]).to eq(params[:body])
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
end
