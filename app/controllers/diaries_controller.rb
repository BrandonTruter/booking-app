class DiariesController < ApplicationController
  before_action :load_entity

  def index
    @diaries = Diary.all

    respond_to do |format|
      format.html
      format.json {
        render json: @diaries
      }
    end
  end

  private

  def load_entity
    @entity = Entity.find(params[:entity_id])
  end
end
