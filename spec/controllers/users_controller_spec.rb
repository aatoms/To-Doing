require 'rails_helper'

describe UsersController do
  before(:each) do
    @user_2 = create_user_2
    session[:user_id] = @user_2.id
  end

  describe "GET #index" do
    it "unauthenticated users cannot see users index" do
      session[:user_id] = nil
      get :index
      expect(response).to redirect_to sign_in_path
    end

    it "renders the index template for logged in users" do
      get :index
      expect(response).to render_template(:index)
    end

    it "assigns @users" do
      get :index
      expect(assigns(:users)).to eq [@user_2]
    end
  end

  describe "GET #new" do
    it "renders the new user form for logged in users" do
      get :new
      expect(response).to render_template(:new)
    end

    it "assigns @user" do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe "POST #create" do
    it "assigns @user" do
      post :new
      expect(assigns(:user)).to be_a_new(User)
    end

    it "creates a new user when valid params are passed" do
      expect{
        post :create, user: {first_name:"ANNIE", last_name: "the babe", email: "babe@email.com", password: "password", password_confirmation: "password", admin: false}
      }.to change{User.all.count}.from(1).to(2)

      expect(response).to redirect_to user_path(User.last)
      expect(flash[:notice]).to eq "User was created successfully"
    end
  end

  describe "GET #show" do
    it "renders a user for logged in users" do
      user = create_user_1
      get :show, id: user.id
      expect(response).to render_template(:show, id: user.id)
    end

    it "does not display show page to unauthenticated user" do
      user = create_user_1
      session[:user_id] = nil
      get :show, id: user.id
      expect(response).to_not render_template(:show, id: user.id)
      expect(response).to redirect_to sign_in_path
      expect(flash[:danger]).to eq "You must sign in"
    end
  end

  describe "GET #edit" do
    it "will render the edit template for current_user self" do
      user = create_user_1({admin: false})
      session[:user_id] = user.id
      get :edit, id: user.id
      expect(response).to render_template(:edit, id: user.id)
    end

    it "will render the edit template for admin" do
      user = create_user_1({admin: false})
      get :edit, id: user.id
      expect(response).to render_template(:edit, id: user.id)
    end
  end

  describe "PATCH #update" do
    it "will not update for users who are not current user or admin" do
      user = create_user_1({admin: false})
      session[:user_id] = user.id
      expect {
        patch :update, id: @user_2,
        user: {email: "dexter@example.com"}
      }.to_not change{User.first}
      expect(response.status).to eq 404
    end
  end

  describe "DELETE #destroy" do
    it "will not allow users who are not current user or admin to delete users" do
      user = create_user_1({admin: false})
      session[:user_id] = user.id
      expect {
        delete :destroy, id: @user_2
      }.to_not change{User.all.count}
      expect(response.status).to eq 404
    end

    it "will allow admin to delete other users" do
      user = create_user_1({admin: false})
      expect{
        delete :destroy, id: user
      }.to change{User.count}.by(-1)
      expect(response).to redirect_to users_path
      expect(flash[:notice]).to eq "User was successfully deleted"
    end
  end
end
