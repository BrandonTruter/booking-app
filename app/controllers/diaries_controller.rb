class DiariesController < ApplicationController
  before_action :load_entity

  def index
    @diaries = Diary.all
  end

  private

  def load_entity
    @entity = Entity.find(params[:entity_id])
  end
end
