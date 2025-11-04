# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :set_post, only: %i[destroy create]
  before_action :set_like, only: %i[destroy]

  before_action :authenticate_user!

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
    @like = current_user.likes.find_by(id: params[:id])

    redirect_to(@post) unless @like
  end
end
