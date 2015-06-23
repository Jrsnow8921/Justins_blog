# Controller to handle the main route.
#
# Currently this will direct to the login page when no current_user exists,
# and to the angular page otherwise
#
class HomeController < ApplicationController
  skip_authorization_check

  layout 'angular'
  #
  # Method to show the login page
  #
  def index
    # Once someone signs in, hand things over to the angular page
    if current_user && user_signed_in?
      #@post = Post.all
      respond_to do |format|
        format.json { render json: Post.all }
        format.html
      end

    else
      redirect_to new_user_session_path
    end
  end

  
  def create
    respond_with Post.create(post_params)
  end


  private

  def post_params
    params.permit(:id, :created_at, :updated_at, :post_text, :user, :SUBJECT, :FIRST_NAME, :LAST_NAME, :EMAIL)
  end
end

