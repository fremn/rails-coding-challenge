class JobsController < ApplicationController
  def index
    @jobs = Job.where(user: current_user) if current_user
  end

  def new
    @job = Job.new
  end

  def create
    @job = Job.new(permitted_params.merge(user: current_user))
    respond_to do |format|
      if @job.save
        format.html { redirect_to root_path, notice: 'Your job has been posted.' }
      else
        format.html { render :new }
      end
    end
  end

  private

  def permitted_params
    params.require(:job).permit(:name, :description, :status, :employment_type)
  end
end
