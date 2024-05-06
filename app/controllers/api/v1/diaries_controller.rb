class Api::V1::DiariesController < ApplicationController
  # GET /api/v1/diaries
  def index
    render json: GxWeb::Client.new.list_diaries || Diary.all
  end
end
