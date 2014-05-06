require "spec_helper"

describe UserPostsController do
  describe "routing" do

    it "routes to #index" do
      get("/user_posts").should route_to("user_posts#index")
    end

    it "routes to #new" do
      get("/user_posts/new").should route_to("user_posts#new")
    end

    it "routes to #show" do
      get("/user_posts/1").should route_to("user_posts#show", :id => "1")
    end

    it "routes to #edit" do
      get("/user_posts/1/edit").should route_to("user_posts#edit", :id => "1")
    end

    it "routes to #create" do
      post("/user_posts").should route_to("user_posts#create")
    end

    it "routes to #update" do
      put("/user_posts/1").should route_to("user_posts#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/user_posts/1").should route_to("user_posts#destroy", :id => "1")
    end

  end
end
