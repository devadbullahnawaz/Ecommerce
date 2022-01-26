# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_product_id, only: %i[index new]
  before_action :set_comment_id, only: %i[edit update destroy]
  before_action :authorization_of_comment, only: %i[update destroy]

  def index
    @comments = Comment.all
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    authorize @comment
    render json: { message: 'Comment not created' } unless @comment.save
  end

  def edit
    if @comment.nil?
      redirect_to root_path, notice: 'Comment not found'
    else
      authorize @comment
      @product = @comment.product
    end
  end

  def update
    if @comment.update(comment_params)
      redirect_to product_path(@comment.product_id)
    else
      render :edit
    end
  end

  def destroy
    if @comment.destroy
      redirect_to product_path(@comment.product_id)
    else
      redirect_to root_path, notice: 'Comment has not been deleted'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :user_id, :product_id)
  end

  def set_product_id
    @product_id = params[:product_id] if params[:product_id].present?
  end

  def set_comment_id
    @comment = Comment.find_by(id: params[:id])
  end

  def authorization_of_comment
    authorize @comment
  end
end
