require 'rails_helper'

RSpec.describe "Tweets", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:token) { JWT.encode({ user_id: user.id }, 'SECRET') }
  let(:headers) { { ACCEPT: 'application/json', Authorization: "Bearer #{token}" } }

  describe "GET /tweets - index action" do
    subject do
      get "/users/#{user.id}/tweets", headers: headers
      response
    end

    context 'shows all tweets' do
      let(:other_user) { FactoryBot.create(:user, username: 'steve') }
      
      before do
        FactoryBot.create(:tweet, user: user, content: 'First tweet')
        FactoryBot.create(:tweet, user: user, content: 'Second tweet')
        FactoryBot.create(:tweet, user: other_user, content: 'My tweet')
      end

      it do
        expect(subject.parsed_body).to include(
          {
            'tweets' => [
              {
                'content' => 'First tweet',
              },
              {
                'content' => 'Second tweet',
              },
            ]
          }
        )
      end
    end
  end

  describe "GET /tweets/:id - show action" do
    subject do
      get "/users/#{user_id}/tweets/#{tweet_id}", headers: headers
      response
    end

    let(:tweet) do
      FactoryBot.create(:tweet, user: user, content: 'First tweet')
    end

    context 'the user does not exist' do
      let(:user_id) { 0 }
      let(:tweet_id) { 0 }
      it { expect(subject.parsed_body).to include({ "error" => 'Wrong token' }) }
    end

    context 'the user exists' do
      let(:user_id) { user.id }

      context 'but the tweet does not exist' do
        let(:tweet_id) { 0 }

        it { expect { subject }.to raise_error(ActiveRecord::RecordNotFound) }
      end
      
      context 'and the tweet exists' do
        let(:tweet_id) { tweet.id }

        it do
          expect(subject.parsed_body).to include({ 'content' => 'First tweet' })
        end
      end
    end
  end

  describe "POST /tweets - create action" do
    subject do
      post "/users/#{user.id}/tweets", headers: headers, params: params
      response
    end

    context 'the tweet is created correctly' do
      let(:params) { { content: 'My first tweet' } }

      it do
        expect{ subject }.to change { user.tweets.first }.from(nil).to have_attributes({
          content: 'My first tweet',
          likes: 0,
        })
        expect(subject.parsed_body).to include({
          "content" => "My first tweet",
        })

      end
    end
  end
end
