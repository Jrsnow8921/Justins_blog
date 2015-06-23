class PostController < ApplicationController

  skip_authorization_check
	
  skip_before_filter :verify_authenticity_token

  before_action :authenticate_user!

  layout 'angular'


  def index
    @post = Post.all
  end

  def show
    @post = Post.all
    respond_to do |format|
      format.html # show.html.haml
      format.xml  { render :xml => @post }
    end
  end

  def new
    @post = Post.new

    respond_to do |format|
      format.html# new.html.haml
      format.xml { render :xml => @post }
      format.json { render json: @post }
    end
  end

  def create
    @post = Post.new(post_params)
    @post.save!
     
    respond_to do |format|

      if @post.save
        format.html { redirect_to(root_url( @post ), :notice => 'Your blog post was created') }
        format.xml { render :xml => @post, :status => :created, :location => @post }
      end
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    respond_to do |format|
      format.html { redirect_to(home_index_path) }
      format.xml { head :ok }
    end
  end

  private

  def post_params
    params.permit(:id, :created_at, :updated_at, :post_text, :user, :SUBJECT, :FIRST_NAME, :LAST_NAME, :EMAIL)
  end
end
