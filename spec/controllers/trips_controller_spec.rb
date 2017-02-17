require 'rails_helper'

describe TripsController do
  describe 'new' do
    context 'when user logged in' do
      login_user

      it 'renders new' do
        get :new
        expect(response).to have_http_status(:success)
      end
    end

    context 'when user not logged in' do
      it 'redirects to sign in path' do
        get :new
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
