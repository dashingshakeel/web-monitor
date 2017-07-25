class SupervisorsController < ApplicationController

  def index
    @supervisors = Supervisor.all
  end
end
