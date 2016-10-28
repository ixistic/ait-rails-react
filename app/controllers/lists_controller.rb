class ListsController < ApplicationController
  before_action :set_list, only: [:update, :destroy]

  def index
    @lists = List.all
  end

  def create
    @list = List.new(list_params)
    if @list.save
      render json: @list
    else
      render json: @list.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @list.destroy
    head :no_content
  end

  def update
    if @list.update(list_params)
      render json: @list
    else
      render json: @list.errors, status: :unprocessable_entity
    end
  end

  private

  def list_params
    params.require(:list).permit(:title, :description, :amount)
  end

  def set_list
    @list = List.find(params[:id])
  end

end
