class CommentsController < ApplicationController
  before_action :set_comment, only: %i[ update destroy ]
  before_action :authenticate_user!
  before_action :allow_only_author, only: %i[ update destroy ]

  # POST /comments or /comments.json
  def create
    @comment = current_user.comments.new(comment_params.merge(post_id: params.expect(:post_id)))

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment.post, notice: "Comment was successfully created." }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { redirect_to @comment.post, status: :unprocessable_content, alert: "Something went wrong" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment.post, notice: "Comment was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    @comment.destroy!

    respond_to do |format|
      format.html { redirect_to @comment.post, notice: "Comment was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private

    def allow_only_author
      redirect_to(root_path, status: :forbidden) unless @comment.author == current_user
    end

    def set_comment
      @comment = PostComment.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.expect(comment: [ :content, :ancestry ])
    end
end
