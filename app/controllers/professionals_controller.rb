class ProfessionalsController < ApplicationController
  def index
    @professionals = Professional.all
  end

  def show
    @professional = Professional.find(params[:id])
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end
end
