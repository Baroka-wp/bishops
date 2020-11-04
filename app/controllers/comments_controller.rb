class CommentsController < ApplicationController
  before_action :set_startup, only: %i[create edit update destroy]
  before_action :login_check, only: %i[create edit destroy]
  def create
    @comment = @startup.comments.build(comment_params)
    @comment.user_id = current_user.id
    respond_to do |format|
      if @startup.save
        format.js { render :index }
      else
        format.html { redirect_to startup_path(@startup), notice: "Couldn't post..." }
      end
    end
  end

  def edit
    @comment = @startup.comments.find(params[:id])
    respond_to do |format|
      flash.now[:notice] = 'modifier le commentaires'
      format.js { render :edit }
    end
  end

  def update
    @comment = @startup.comments.find(params[:id])
    respond_to do |format|
      if @comment.update(comment_params)
        flash.now[:notice] = 'Commentaire mis a jour'
        format.js { render :index }
      else
        flash.now[:notice] = 'commentaire non mis à jour'
        format.js { render :edit_error }
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    respond_to do |format|
      flash.now[:notice] = 'Comment deleted'
      format.js { render :index }
    end
 end

  private

  def comment_params
    params.require(:comment).permit(:startup_id, :content)
  end

  def set_startup
    @startup = Startup.find(params[:startup_id])
  end

  def login_check
    unless user_signed_in?
      redirect_to new_user_session_path, notice: 'you are not login, please login or create new accompt'
    end
  end
end
