# -*- coding: utf-8 -*-
require "kconv"
require 'csv'
class YoubridesController < ApplicationController
  before_action :set_youbride, only: [:show, :edit, :update, :destroy]

  # GET /youbrides
  # GET /youbrides.json
  def index
    @youbrides = Youbride.all
  end

  # GET /youbrides/1
  # GET /youbrides/1.json
  def show
  end

  # GET /youbrides/new
  def new
    @youbride = Youbride.new
  end

  # GET /youbrides/1/edit
  def edit
  end

  # POST /youbrides
  # POST /youbrides.json
  def create
    @youbride = Youbride.new(youbride_params)

    respond_to do |format|
      if @youbride.save
        format.html { redirect_to @youbride, notice: 'Youbride was successfully created.' }
        format.json { render :show, status: :created, location: @youbride }
      else
        format.html { render :new }
        format.json { render json: @youbride.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /youbrides/1
  # PATCH/PUT /youbrides/1.json
  def update
    respond_to do |format|
      if @youbride.update(youbride_params)
        format.html { redirect_to @youbride, notice: 'Youbride was successfully updated.' }
        format.json { render :show, status: :ok, location: @youbride }
      else
        format.html { render :edit }
        format.json { render json: @youbride.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /youbrides/1
  # DELETE /youbrides/1.json
  def destroy
    @youbride.destroy
    respond_to do |format|
      format.html { redirect_to youbrides_url, notice: 'Youbride was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def csv_download
    outfile = "Youbride_" + Time.now.strftime("%Y%m%d%H%M") + ".csv"
    csv_udata = CSV.generate do |csv|
      csv << Youbride.first.class.csv_head
      Youbride.all.each{|event|csv << event.csv_data; logger.debug event.inspect}        
    end
    # CSVファイルダウンロード
    #   文字コード変換(UTF8→SHIFT-JIS)
    send_data NKF.nkf("-s",csv_udata),
      :type => 'text/comma-separated-values; charset=iso-8859-1; header=present',
      :disposition => "attachment; filename=#{outfile}"
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_youbride
      @youbride = Youbride.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def youbride_params
      params.fetch(:youbride, {})
    end
    def youbride_params
      params.require(:youbride).permit(:event_url, :main_image_url, :venue_name, :postalcode, :prefecture_name, :address, :event_date_time, :title, :description, :reservation_state_for_male, :reservation_state_for_female, :price_for_male, :price_for_female, :eligibility_for_male, :eligibility_for_female, :age_range_for_male, :age_range_for_female, :cancellation_policy)
    end
end
