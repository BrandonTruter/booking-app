class Api::V1::DebtorsController < ApplicationController
  def index
    render json: GxWeb::Client.new.list_debtors || Debtor.all
  end
end
