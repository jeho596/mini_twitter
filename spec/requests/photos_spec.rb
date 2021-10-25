require 'rails_helper'

RSpec.describe "Photos", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:headers) { { ACCEPT: 'application/json' } }

  describe "POST /photos - create action" do
    subject do
      post "/users/#{user_id}/photos", headers: headers, params: params
      response
    end

    context 'the photo is created correctly' do
      let(:params) { { url: 'img/user' } }
      let(:user_id) { user.id }

      it do
        expect{ subject }.to change { user.reload.photo }.from(nil).to have_attributes({
           url: 'img/user'
        })
        expect(subject.parsed_body).to include({
          "url" => "img/user"
        })

      end
    end

    context 'the user does not exist' do
      let(:params) { { url: 'img/user' } }
      let(:user_id) { 0 }

      it { expect(subject.parsed_body).to include({ "error" => 'User not found' }) }

    end

    context 'the params are invalid' do
      let(:params) { { url: '' } }
      let(:user_id) { user.id }

      it { expect(subject.parsed_body).to include("Url can't be blank") }

    end
  end
end

