class ProjectsController < ApplicationController
  before_action :require_login, only: [:new, :edit]
  before_action :set_categories, only: [:new]
  before_action :set_countries, only: [:new]

  def show
    @project = Project.find(params[:id])
  end

  def new
    @project = Project.new
  end

  def create
    city = City.find_or_create_by(
      name: params[:project][:city],
      country_id: params[:project][:country_id])
    params[:project].merge!({city_id: city.id})
    @project = current_user.projects.create(project_params)

    if @project.save
      redirect_to new_reward_path(project_id: @project.id)
    else
      redirect_to new_project_path
      flash[:warning] = "Please fill in all fields."
    end
  end

  def edit
    @project = Project.find(params[:id])
    check_project_owner(@project)
  end

  def update
    city = City.find_or_create_by(
      name: params[:project][:city],
      country_id: params[:project][:country_id])
    params[:project].merge!({city_id: city.id})
    @project = Project.find(params[:id])
    @project.update(project_params)

    if @project.save
      redirect_to project_path(@project)
    else
      redirect_to new_project_path
      flash[:warning] = "Please fill in all fields."
    end
  end


  private
    def project_params
      params.require(:project).permit(:title,
                                      :description,
                                      :image_url,
                                      :target_amount,
                                      :category_id,
                                      :city_id,
                                      :country_id,
                                      :completion_date)
    end

    def set_categories
      @categories = Category.category_list
    end

    def set_countries
      @countries = Country.country_list
    end
end
