class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  layout 'dashboard', only: [:my_comments, :comments_to_me]

  # POST /comments
  # POST /comments.json
  def create
    @comment = current_user.comments.new(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to blog_path(comment_params[:blog_id]), notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    url = Rails.application.routes.recognize_path(request.referrer)
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to url, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def my_comments
    @comments = current_user.comments
  end

  def comments_to_me
    @comments = Comment.joins(:blog).where(user_id: current_user.id)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:body, :blog_id, :comment_id)
    end
end
