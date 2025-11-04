class LikesController < ApplicationController
  before_action :set_post, only: %i[create]
  before_action :set_like, only: %i[destroy]

  def create
    @post.likes.create(user_id: current_user.id)

    redirect_to @post
  end

  def destroy
    @like.destroy

    redirect_to @like.post
  end

  private

    def set_post
      @post = Post.find(params[:post_id])
    end

    def set_like
      @like = current_user.likes.find(params[:id])
    end
end
