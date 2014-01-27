require 'spec_helper'

describe AccountsController do
  let(:user) { create(:user) }
  before { sign_in user }

  describe 'POST #create' do
    it 'creates a new account for a user' do
      request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:github]

      expect do
        post :create, provider: 'github'
      end.to change(user.accounts, :count).by(1)
    end
  end

  describe 'DELETE #destroy' do
    let!(:account) { create(:account, user: user) }

    it 'destroys an account for a user' do
      request.env["HTTP_REFERER"] = "http://example.com/back"

      expect {
        delete :destroy, id: account.id, user_id: user.id
      }.to change(user.accounts, :count).by(-1)
    end
  end
end
