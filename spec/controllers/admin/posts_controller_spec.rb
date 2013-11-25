require 'spec_helper'

describe Admin::PostsController do
  describe "admin panel" do
    it "#index" do
      get :index
      response.status.should eq 200
    end

    it "#new" do
      get :new
      response.status.should eq 200
    end

    context "#create" do
      it "creates a post with valid params" do
        expect {post :create, :post => {:title => 'title', :content => 'content'}}.to change{Post.count}.by(1)
      end
      it "doesn't create a post when params are invalid" do
        expect {post :create, :post => {:title => 'title'}}.to_not change{Post.count}.by(1)
      end
    end

    context "#update" do
      let(:post) {Post.create(:title => "Old Title", :content => "content")}
      it "updates a post with valid params" do
        expect {
          put :update, {:id => post.id, :post => {:title => "New Title", :content => "content"}}
        }.to change{ post.reload.title }.to("New Title")
      end
      it "doesn't update a post when params are invalid" do
        expect{
          put :update, {:id => post.id, :post => {}}
          }.to_not change{post.reload.title}.to("No Content")
      end
    end
    context "#destroy" do
      let!(:post) { Post.create(title: "Old Title", content: "content") }
      it "deletes a post" do
        expect {
           delete :destroy, :id => post.id
        }.to change{Post.count}.by(-1)
      end
    end
  end  
end
