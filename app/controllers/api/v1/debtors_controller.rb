class Api::V1::DebtorsController < Api::BaseController
  def index
    render json: GxWeb::Client.new.list_debtors || Debtor.all
  end
end
