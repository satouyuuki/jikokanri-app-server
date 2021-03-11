class TargetsController < ApplicationController
  def show
    @target = Target.all
    render json: @target
  end
end
