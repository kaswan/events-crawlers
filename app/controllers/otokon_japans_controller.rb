# -*- coding: utf-8 -*-
require "kconv"
require 'csv'
class OtokonJapansController < ApplicationController
  before_action :set_otokon_japan, only: [:show, :edit, :update, :destroy]

  # GET /otokon_japans
  # GET /otokon_japans.json
  def index
    @otokon_japans = OtokonJapan.all
    @posts = Post.all
  end

  # GET /otokon_japans/1
  # GET /otokon_japans/1.json
  def show
  end

  # GET /otokon_japans/new
  def new
    @otokon_japan = OtokonJapan.new
  end

  # GET /otokon_japans/1/edit
  def edit
  end

  # POST /otokon_japans
  # POST /otokon_japans.json
  def create
    @otokon_japan = OtokonJapan.new(otokon_japan_params)

    respond_to do |format|
      if @otokon_japan.save
        format.html { redirect_to @otokon_japan, notice: 'Otokon japan was successfully created.' }
        format.json { render :show, status: :created, location: @otokon_japan }
      else
        format.html { render :new }
        format.json { render json: @otokon_japan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /otokon_japans/1
  # PATCH/PUT /otokon_japans/1.json
  def update
    respond_to do |format|
      if @otokon_japan.update(otokon_japan_params)
        format.html { redirect_to @otokon_japan, notice: 'Otokon japan was successfully updated.' }
        format.json { render :show, status: :ok, location: @otokon_japan }
      else
        format.html { render :edit }
        format.json { render json: @otokon_japan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /otokon_japans/1
  # DELETE /otokon_japans/1.json
  def destroy
    @otokon_japan.destroy
    respond_to do |format|
      format.html { redirect_to otokon_japans_url, notice: 'Otokon japan was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def csv_download
    outfile = "Otokon_" + Time.now.strftime("%Y%m%d%H%M") + ".csv"
    csv_udata = CSV.generate do |csv|
      csv << OtokonJapan.first.class.csv_head
      OtokonJapan.all.each{|event|csv << event.csv_data; logger.debug event.inspect}        
    end
    # CSVファイルダウンロード
    #   文字コード変換(UTF8→SHIFT-JIS)
    send_data NKF.nkf("-s",csv_udata),
      :type => 'text/comma-separated-values; charset=iso-8859-1; header=present',
      :disposition => "attachment; filename=#{outfile}"
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_otokon_japan
      @otokon_japan = OtokonJapan.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def otokon_japan_params
      params.require(:otokon_japan).permit(:event_url, :main_image_url, :venue_name, :postalcode, :prefecture_name, :address, :event_date_time, :title, :description, :reservation_state_for_male, :reservation_state_for_female, :price_for_male, :price_for_female, :eligibility_for_male, :eligibility_for_female, :age_range_for_male, :age_range_for_female, :important_reminder, :all_images_link)
    end
end
