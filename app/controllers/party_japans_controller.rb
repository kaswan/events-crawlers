# -*- coding: utf-8 -*-
require "kconv"
require 'csv'
class PartyJapansController < ApplicationController
  before_action :set_party_japan, only: [:show, :edit, :update, :destroy]

  # GET /party_japans
  # GET /party_japans.json
  def index
    @party_japans = PartyJapan.all
    @posts = Post.all
  end

  # GET /party_japans/1
  # GET /party_japans/1.json
  def show
  end

  # GET /party_japans/new
  def new
    @party_japan = PartyJapan.new
  end

  # GET /party_japans/1/edit
  def edit
  end

  # POST /party_japans
  # POST /party_japans.json
  def create
    @party_japan = PartyJapan.new(party_japan_params)

    respond_to do |format|
      if @party_japan.save
        format.html { redirect_to @party_japan, notice: 'Party japan was successfully created.' }
        format.json { render :show, status: :created, location: @party_japan }
      else
        format.html { render :new }
        format.json { render json: @party_japan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /party_japans/1
  # PATCH/PUT /party_japans/1.json
  def update
    respond_to do |format|
      if @party_japan.update(party_japan_params)
        format.html { redirect_to @party_japan, notice: 'Party japan was successfully updated.' }
        format.json { render :show, status: :ok, location: @party_japan }
      else
        format.html { render :edit }
        format.json { render json: @party_japan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /party_japans/1
  # DELETE /party_japans/1.json
  def destroy
    @party_japan.destroy
    respond_to do |format|
      format.html { redirect_to party_japans_url, notice: 'Party japan was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def csv_download
    outfile = "Party_" + Time.now.strftime("%Y%m%d%H%M") + ".csv"
    csv_udata = CSV.generate do |csv|
      csv << PartyJapan.first.class.csv_head
      PartyJapan.all.each{|event|csv << event.csv_data; logger.debug event.inspect}        
    end
    # CSVファイルダウンロード
    #   文字コード変換(UTF8→SHIFT-JIS)
    send_data NKF.nkf("-s",csv_udata),
      :type => 'text/comma-separated-values; charset=iso-8859-1; header=present',
      :disposition => "attachment; filename=#{outfile}"
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_party_japan
      @party_japan = PartyJapan.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def party_japan_params
      params.require(:party_japan).permit(:event_url, :main_image_url, :venue_name, :postalcode, :prefecture_name, :address, :event_date_time, :title, :description, :reservation_state_for_male, :reservation_state_for_female, :price_for_male, :price_for_female, :eligibility_for_male, :eligibility_for_female, :age_range_for_male, :age_range_for_female, :important_reminder, :all_images_link)
    end
end
