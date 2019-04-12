class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:landing, :professional_info, :teacher_info]


  def home
  end

  def landing
    @disable_nav = true
  end

  def professional_info
    @disable_nav = true
  end

  def teacher_info
    @disable_nav = true
  end
end
