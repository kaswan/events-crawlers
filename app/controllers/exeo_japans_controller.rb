# -*- coding: utf-8 -*-
require "kconv"
require 'csv'
class ExeoJapansController < ApplicationController
  before_action :set_exeo_japan, only: [:show, :edit, :update, :destroy]

  # GET /exeo_japans
  # GET /exeo_japans.json
  def index
    @exeo_japans = ExeoJapan.all
  end

  # GET /exeo_japans/1
  # GET /exeo_japans/1.json
  def show
  end

  # GET /exeo_japans/new
  def new
    @exeo_japan = ExeoJapan.new
  end

  # GET /exeo_japans/1/edit
  def edit
  end

  # POST /exeo_japans
  # POST /exeo_japans.json
  def create
    @exeo_japan = ExeoJapan.new(exeo_japan_params)

    respond_to do |format|
      if @exeo_japan.save
        format.html { redirect_to @exeo_japan, notice: 'Exeo japan was successfully created.' }
        format.json { render :show, status: :created, location: @exeo_japan }
      else
        format.html { render :new }
        format.json { render json: @exeo_japan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /exeo_japans/1
  # PATCH/PUT /exeo_japans/1.json
  def update
    respond_to do |format|
      if @exeo_japan.update(exeo_japan_params)
        format.html { redirect_to @exeo_japan, notice: 'Exeo japan was successfully updated.' }
        format.json { render :show, status: :ok, location: @exeo_japan }
      else
        format.html { render :edit }
        format.json { render json: @exeo_japan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /exeo_japans/1
  # DELETE /exeo_japans/1.json
  def destroy
    @exeo_japan.destroy
    respond_to do |format|
      format.html { redirect_to exeo_japans_url, notice: 'Exeo japan was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def csv_download
    outfile = "Exeo_" + Time.now.strftime("%Y%m%d%H%M") + ".csv"
    csv_udata = CSV.generate do |csv|
      csv << ExeoJapan.first.class.csv_head
      ExeoJapan.all.each{|event|csv << event.csv_data; logger.debug event.inspect}        
    end
    # CSVファイルダウンロード
    #   文字コード変換(UTF8→SHIFT-JIS)
    send_data NKF.nkf("-s",csv_udata),
      :type => 'text/comma-separated-values; charset=iso-8859-1; header=present',
      :disposition => "attachment; filename=#{outfile}"
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_exeo_japan
      @exeo_japan = ExeoJapan.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def exeo_japan_params
      params.require(:exeo_japan).permit(:event_url, :main_image_url, :venue_name, :postalcode, :prefecture_name, :address, :event_date_time, :title, :description, :reservation_state_for_male, :reservation_state_for_female, :price_for_male, :price_for_female, :eligibility_for_male, :eligibility_for_female, :age_range_for_male, :age_range_for_female, :important_reminder, :all_images_link)
    end
end
