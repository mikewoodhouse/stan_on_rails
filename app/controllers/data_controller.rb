require "db_query"

class DataController < ApplicationController
  def get
    sql = DbQuery.new.send(params[:dataset].to_sym)
    rows = ActiveRecord::Base.connection.exec_query(sql, "Players", [100, 2010])
    respond_to do |format|
      format.json {
        render json: { params[:dataset] => rows.to_a }
      }
    end
  end

  def records
    @page_title = "Statistical Loveliness"
  end
end
