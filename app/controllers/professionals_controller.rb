class ProfessionalsController < ApplicationController
  before_action :set_professional, only: [:show, :edit, :update]

  def index
    @professionals = Professional.all
    @tag = params["query"]
    if @tag.present?
      @professionals = Professional.tagged_with(@tag)
    end
  end


  def show
  end

  def new
    @professional = Professional.new
  end

  def create
    @professional = Professional.new(professional_params)
    @professional.user = current_user
    if @professional.save
      redirect_to user_path(current_user)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @professional.update(professional_params)
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end

  def tagged
    if params[:tag].present?
      @professionals = Professional.tagged_with(params[:expertise_list])
    else
      @professionals = Professioanl.all
    end
  end

  private

  def set_professional
    @professional = Professional.find(params[:id])
  end

  def professional_params
    params.require(:professional).permit(:company, :title, :description, :city, :linkedin_url, :expertise_list)
  end
end
