class SessionsController < ApplicationController

  def index
    @sessions = Session.includes(:user).includes(:calculation).page(params[:page]).per(20)
  end

  def show
    @session = Session.find(params[:id])
    render json: @session.hrm_data_points
  end
end