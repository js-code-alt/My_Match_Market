class PostsController < ApplicationController

  before_action :set_channel, only: :create

  def create
    @post = Post.new(post_params)
    @post.channel = @channel
    @post.user = current_user

    # if @post.save
    #   # get this checked
    #   redirect_to channel_path(@channel)
    # else
    #   render "channels/show", status: :unprocessable_entity
    # end

    respond_to do |format|
      if @post.save
        format.html { redirect_to channel_path(@channel), notice: 'Post was successfully created.' }
        # format.json { render json: { success: true, post_html: render_to_string(partial: 'posts/post', locals: { post: @post }) } }
      else
        format.html { render "channels/show", status: :unprocessable_entity  }
        # format.json { render json: { success: false, errors: @post.errors.full_messages } }
      end
    end
  end

  private


  def set_channel
    @channel = Channel.find(params[:channel_id])
  end

  def post_params
    params.require(:post).permit(:title, :description)
  end

end
