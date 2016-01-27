class ReportController < ApplicationController
  def index
  end
 
  def output
    #TODO
    @repo = Solitem.order(":id, :req_id, :user_id")
  end
end
