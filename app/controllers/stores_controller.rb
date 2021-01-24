class StoresController < ApplicationController
  def index
    @stores = Store.all

    render json: @stores, include: :balance
  end

  def show
    @store = Store.find_by(id: permit_params[:id])

    render json: @store, include: :balance
  end

  private

  def permit_params
    params.permit(:id)
  end
end
