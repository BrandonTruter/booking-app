class Api::V1::DiariesController < ApplicationController
  before_action :fetch_diaries

  # GET /diaries
  def index
    render json: @diaries
  end

  private

  def fetch_diaries
    @diaries = GxWeb::Client.new.list_diaries || Diary.all
  end
end
