class PostController < ApplicationController

  skip_authorization_check
	
  skip_before_filter :verify_authenticity_token

  before_action :authenticate_user!

  layout 'angular'
 
  respond_to :json

  def index
    respond_to do |format|
      format.json { render json: Post.all }
      format.html
    end
  end

  def create
    respond_with Post.create(post_params)
  end

  def destroy
    respond_with Post.destroy(params[:id])
  end

  def destroy
     respond_with Post.destroy(params[:id])
  end

  private

  def post_params
    params.require(:post).permit(:id, :created_at, :updated_at, :post_text, :user, :SUBJECT, :FIRST_NAME, :LAST_NAME, :EMAIL)
  end
end
