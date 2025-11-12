# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: %i[index show]
  before_action :allow_only_author, only: %i[edit update destroy]

  # GET /posts
  def index
    @posts = Post.order(created_at: :desc)
  end

  # GET /posts/1
  def show; end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit; end

  # POST /posts
  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to @post, notice: t('posts.created')
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  def update
    if @post.update(post_params)
      redirect_to @post, notice: t('posts.updated'), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy!

    redirect_to posts_path, notice: t('posts.destroyed'), status: :see_other
  end

  private

  def allow_only_author
    redirect_to(root_path, status: :forbidden) unless @post.creator == current_user
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.expect(post: %i[title body category_id])
  end
end
