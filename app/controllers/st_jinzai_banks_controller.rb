# -*- coding: utf-8 -*-
require "kconv"
require 'csv'
class StJinzaiBanksController < ApplicationController
  before_action :set_st_jinzai_bank, only: [:show, :edit, :update, :destroy]

  # GET /st_jinzai_banks
  # GET /st_jinzai_banks.json
  def index
    @st_jinzai_banks = StJinzaiBank.all
  end

  # GET /st_jinzai_banks/1
  # GET /st_jinzai_banks/1.json
  def show
  end

  # GET /st_jinzai_banks/new
  def new
    @st_jinzai_bank = StJinzaiBank.new
  end

  # GET /st_jinzai_banks/1/edit
  def edit
  end

  # POST /st_jinzai_banks
  # POST /st_jinzai_banks.json
  def create
    @st_jinzai_bank = StJinzaiBank.new(st_jinzai_bank_params)

    respond_to do |format|
      if @st_jinzai_bank.save
        format.html { redirect_to @st_jinzai_bank, notice: 'St jinzai bank was successfully created.' }
        format.json { render :show, status: :created, location: @st_jinzai_bank }
      else
        format.html { render :new }
        format.json { render json: @st_jinzai_bank.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /st_jinzai_banks/1
  # PATCH/PUT /st_jinzai_banks/1.json
  def update
    respond_to do |format|
      if @st_jinzai_bank.update(st_jinzai_bank_params)
        format.html { redirect_to @st_jinzai_bank, notice: 'St jinzai bank was successfully updated.' }
        format.json { render :show, status: :ok, location: @st_jinzai_bank }
      else
        format.html { render :edit }
        format.json { render json: @st_jinzai_bank.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /st_jinzai_banks/1
  # DELETE /st_jinzai_banks/1.json
  def destroy
    @st_jinzai_bank.destroy
    respond_to do |format|
      format.html { redirect_to st_jinzai_banks_url, notice: 'St jinzai bank was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def csv_download
    outfile = "StJinzaiBank_" + Time.now.strftime("%Y%m%d%H%M") + ".csv"
    csv_udata = CSV.generate do |csv|
      csv << StJinzaiBank.first.class.csv_head
      StJinzaiBank.all.each{|offer|csv << offer.csv_data; logger.debug offer.inspect}        
    end
    # CSVファイルダウンロード
    #   文字コード変換(UTF8→SHIFT-JIS)
    send_data NKF.nkf("-s",csv_udata),
      :type => 'text/comma-separated-values; charset=iso-8859-1; header=present',
      :disposition => "attachment; filename=#{outfile}"
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_st_jinzai_bank
      @st_jinzai_bank = StJinzaiBank.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def st_jinzai_bank_params
      params.require(:st_jinzai_bank).permit(:page_url, :title, :sub_title, :job_feature, :salary, :working_hours, :holiday_vacation, :job_category, :employment_type, :job_detail, :recommended_comment, :workplace_feature, :corporate_name, :office_name, :institution_type, :work_location, :postalcode, :prefecture, :nearest_station)
    end
end
