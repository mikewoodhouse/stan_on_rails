class DataController < ApplicationController
  def get
    dataset_name = params[:dataset]
    j = JSON.parse(File.open(Rails.root + "app/javascript/#{dataset_name}.json", "r").read())
    respond_to do |format|
      format.json {
        render json: { "#{dataset_name}": j }
      }
    end
  end
end
