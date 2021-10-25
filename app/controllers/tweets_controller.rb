class TweetsController < ApplicationController
    before_action :authorized
    before_action :user_validation
  
    def index
      @user = user
      @tweets = @user.tweets
    end
  
    def show
      @tweet = user.tweets.find(params[:id])
    end
  
    def create
      @tweet = user.tweets.create(content: params[:content], likes: 0)    
    end
  
    def like
      @tweet = user.tweets.find(params[:id])
      likes = @tweet.likes + 1
      @tweet.update(likes: likes)
    end
  
  private
    def user
      User.find(user_id)
    end
  
    def user_validation
      render json: { error: 'Wrong token' } unless user_id.to_s == params[:user_id]
    end
  
    def authorized
      return render json: { error: 'Not authorized'} unless token
  
      @token_info = JWT.decode(token, 'SECRET')
    rescue JWT::DecodeError
      render json: { error: 'Invalid authorization'}
    end
  
    def token 
      request.headers['Authorization'].split(' ')[1]
    end
  
    def user_id
      @token_info[0]['user_id']
    end
  end
