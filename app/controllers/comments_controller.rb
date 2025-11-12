# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_comment, only: %i[update destroy]
  before_action :authenticate_user!
  before_action :allow_only_author, only: %i[update destroy]

  # POST /comments
  def create
    @comment = current_user.comments.new(comment_params.merge(post_id: params.expect(:post_id)))

    if @comment.save
      redirect_to @comment.post, notice: t('.created', resource: @comment.model_name.human)
    else
      redirect_to @comment.post, status: :unprocessable_content, alert: t('comments.error')
    end
  end

  # PATCH/PUT /comments/1
  def update
    if @comment.update(comment_params)
      redirect_to @comment.post, notice: t('.updated', resource: @comment.model_name.human), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /comments/1
  def destroy
    @comment.destroy!

    redirect_to @comment.post, notice: t('.destroyed', resource: @comment.model_name.human), status: :see_other
  end

  private

  def allow_only_author
    redirect_to(root_path, status: :forbidden) unless @comment.user == current_user
  end

  def set_comment
    @comment = PostComment.find(params.expect(:id))
  end

  def comment_params
    params.expect(post_comment: %i[content ancestry])
  end
end
