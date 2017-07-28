# -*- coding: utf-8 -*-
require "kconv"
require 'csv'
class OtJinzaiBanksController < ApplicationController
  before_action :set_ot_jinzai_bank, only: [:show, :edit, :update, :destroy]

  # GET /ot_jinzai_banks
  # GET /ot_jinzai_banks.json
  def index
    @ot_jinzai_banks = OtJinzaiBank.all
  end

  # GET /ot_jinzai_banks/1
  # GET /ot_jinzai_banks/1.json
  def show
  end

  # GET /ot_jinzai_banks/new
  def new
    @ot_jinzai_bank = OtJinzaiBank.new
  end

  # GET /ot_jinzai_banks/1/edit
  def edit
  end

  # POST /ot_jinzai_banks
  # POST /ot_jinzai_banks.json
  def create
    @ot_jinzai_bank = OtJinzaiBank.new(ot_jinzai_bank_params)

    respond_to do |format|
      if @ot_jinzai_bank.save
        format.html { redirect_to @ot_jinzai_bank, notice: 'Ot jinzai bank was successfully created.' }
        format.json { render :show, status: :created, location: @ot_jinzai_bank }
      else
        format.html { render :new }
        format.json { render json: @ot_jinzai_bank.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ot_jinzai_banks/1
  # PATCH/PUT /ot_jinzai_banks/1.json
  def update
    respond_to do |format|
      if @ot_jinzai_bank.update(ot_jinzai_bank_params)
        format.html { redirect_to @ot_jinzai_bank, notice: 'Ot jinzai bank was successfully updated.' }
        format.json { render :show, status: :ok, location: @ot_jinzai_bank }
      else
        format.html { render :edit }
        format.json { render json: @ot_jinzai_bank.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ot_jinzai_banks/1
  # DELETE /ot_jinzai_banks/1.json
  def destroy
    @ot_jinzai_bank.destroy
    respond_to do |format|
      format.html { redirect_to ot_jinzai_banks_url, notice: 'Ot jinzai bank was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def csv_download
    outfile = "OtJinzaiBank_" + Time.now.strftime("%Y%m%d%H%M") + ".csv"
    csv_udata = CSV.generate do |csv|
      csv << OtJinzaiBank.first.class.csv_head
      OtJinzaiBank.all.each{|offer|csv << offer.csv_data; logger.debug offer.inspect}        
    end
    # CSVファイルダウンロード
    #   文字コード変換(UTF8→SHIFT-JIS)
    send_data NKF.nkf("-s",csv_udata),
      :type => 'text/comma-separated-values; charset=iso-8859-1; header=present',
      :disposition => "attachment; filename=#{outfile}"
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ot_jinzai_bank
      @ot_jinzai_bank = OtJinzaiBank.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ot_jinzai_bank_params
      params.require(:ot_jinzai_bank).permit(:page_url, :title, :sub_title, :job_feature, :salary, :working_hours, :holiday_vacation, :job_category, :employment_type, :job_detail, :recommended_comment, :workplace_feature, :corporate_name, :office_name, :institution_type, :work_location, :postalcode, :prefecture, :nearest_station)
    end
end
