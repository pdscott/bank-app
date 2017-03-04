require 'rails_helper'


describe AccountsController, :type => :controller do
  describe 'GET #index for admin' do
    fixtures :users
    fixtures :accounts
    it 'responds successfully with an HTTP 200 status code' do
      sign_in users(:homer)
      get :index
      expect(response).to have_http_status(200)
      expect(subject.current_user).to_not eq(nil)
    end
  end

  describe 'GET #index for users' do
    fixtures :users
    fixtures :accounts
    it 'responds successfully with an HTTP 200 status code' do
      @user = users(:bart)
      sign_in users(:bart)
      expect(@user.email).to eq('bart@email.com')
      get :index, params: {user_id: @user.id}
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET #show for admin' do
    fixtures :users
    fixtures :accounts
    it 'responds successfully with an HTTP 200 status code' do
      sign_in users(:homer)
      get :show, params: {id: 113629430}
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET #show for user' do
    fixtures :users
    fixtures :accounts
    it 'responds successfully with an HTTP 200 status code' do
      sign_in users(:bart)
      get :show, params: {id: 113629430}
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET #new for admin' do
    fixtures :users
    fixtures :accounts
    it 'responds successfully with an HTTP 200 status code' do
      sign_in users(:homer)
      get :new
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET #new for user' do
    fixtures :users
    fixtures :accounts
    it 'responds successfully with an HTTP 200 status code' do
      sign_in users(:bart)
      get :new
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET #edit for admin' do
    fixtures :users
    fixtures :accounts
    it 'responds successfully with an HTTP 200 status code' do
      sign_in users(:homer)
      get :edit,params: {id: 113629430}
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET #edit for user' do
    fixtures :users
    fixtures :accounts
    it 'responds with a redirect HTTP 302 status code because users cannot edit' do
      sign_in users(:bart)
      get :edit,params: {id: 980190962}
      expect(response).to have_http_status(302)
    end
  end

end