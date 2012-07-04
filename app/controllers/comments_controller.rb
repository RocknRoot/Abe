class CommentsController < ApplicationController
  before_filter :user_loggued
  before_filter :categories

  def toggle_approved
    comment = Comment.find(params[:comment_id])
    if comment.nil?
      redirect_to categories_path
    else
      term = Term.find(comment.term_id)
      if term.nil? or !@current_user or @current_user.id != term.user_id
        redirect_to categories_path
      else
        comment.approved = !comment.approved
        comment.save
        redirect_to term_path(term.id)
      end
    end
  end

  def create
    if params[:comment][:term] == ""
      redirect_to categories_path
    else
      @comment = Comment.new
      @comment.term_id = params[:comment][:term]
      term = Term.find(params[:comment][:term])
      if term.nil? or (!term.public and (!@current_user or @current_user.id != term.user_id))
        redirect_to categories_path
      else
        @comment.content = params[:comment][:content]
        @comment.user_id = @current_user.id
        @comment.save
        redirect_to term_path(params[:comment][:term])
      end
    end
  end
end
