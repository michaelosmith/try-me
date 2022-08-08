class FitnessClassSchedulesController < ApplicationController
  before_action :set_fitness_class_schedule, only: [:show, :edit, :update, :destroy]
  before_action :set_fitness_class, only: [:show, :edit, :update, :destroy]


  def index
    @pagy, @fitness_class_schedules = pagy(FitnessClassSchedule.sort_by_params(params[:sort], sort_direction))

    # Uncomment to authorize with Pundit
    # authorize @clients
  end

  def show
    @fitness_class_clients = @fitness_class_schedule.clients
  end



private

  def set_fitness_class_schedule
    @fitness_class_schedule = FitnessClassSchedule.find(params[:id])
  end
  def set_fitness_class
    @fitness_class_schedule.fitness_class
  end
end