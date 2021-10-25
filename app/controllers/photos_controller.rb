class PhotosController < ApplicationController

    def create
        @photo = user.create_photo(url: params[:url])
        if @photo.save
        else
            render json: @photo.errors.full_messages
        end
    rescue ActiveRecord::RecordNotFound
        render json: { error: 'User not found' } 
    end

private
    def user
      User.find(params[:user_id])
    end

end
