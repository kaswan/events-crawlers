# -*- coding: utf-8 -*-
require "kconv"
require 'csv'
class PtotJinzaiBanksController < ApplicationController
  before_action :set_ptot_jinzai_bank, only: [:show, :edit, :update, :destroy]

  # GET /ptot_jinzai_banks
  # GET /ptot_jinzai_banks.json
  def index
    @ptot_jinzai_banks = PtotJinzaiBank.all
  end

  # GET /ptot_jinzai_banks/1
  # GET /ptot_jinzai_banks/1.json
  def show
  end

  # GET /ptot_jinzai_banks/new
  def new
    @ptot_jinzai_bank = PtotJinzaiBank.new
  end

  # GET /ptot_jinzai_banks/1/edit
  def edit
  end

  # POST /ptot_jinzai_banks
  # POST /ptot_jinzai_banks.json
  def create
    @ptot_jinzai_bank = PtotJinzaiBank.new(ptot_jinzai_bank_params)

    respond_to do |format|
      if @ptot_jinzai_bank.save
        format.html { redirect_to @ptot_jinzai_bank, notice: 'Ptot jinzai bank was successfully created.' }
        format.json { render :show, status: :created, location: @ptot_jinzai_bank }
      else
        format.html { render :new }
        format.json { render json: @ptot_jinzai_bank.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ptot_jinzai_banks/1
  # PATCH/PUT /ptot_jinzai_banks/1.json
  def update
    respond_to do |format|
      if @ptot_jinzai_bank.update(ptot_jinzai_bank_params)
        format.html { redirect_to @ptot_jinzai_bank, notice: 'Ptot jinzai bank was successfully updated.' }
        format.json { render :show, status: :ok, location: @ptot_jinzai_bank }
      else
        format.html { render :edit }
        format.json { render json: @ptot_jinzai_bank.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ptot_jinzai_banks/1
  # DELETE /ptot_jinzai_banks/1.json
  def destroy
    @ptot_jinzai_bank.destroy
    respond_to do |format|
      format.html { redirect_to ptot_jinzai_banks_url, notice: 'Ptot jinzai bank was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def csv_download
    outfile = "PtotJinzaiBank_" + Time.now.strftime("%Y%m%d%H%M") + ".csv"
    csv_udata = CSV.generate do |csv|
      csv << PtotJinzaiBank.first.class.csv_head
      PtotJinzaiBank.all.each{|offer|csv << offer.csv_data; logger.debug offer.inspect}        
    end
    # CSVファイルダウンロード
    #   文字コード変換(UTF8→SHIFT-JIS)
    send_data NKF.nkf("-s",csv_udata),
      :type => 'text/comma-separated-values; charset=iso-8859-1; header=present',
      :disposition => "attachment; filename=#{outfile}"
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ptot_jinzai_bank
      @ptot_jinzai_bank = PtotJinzaiBank.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ptot_jinzai_bank_params
      params.require(:ptot_jinzai_bank).permit(:page_url, :title, :sub_title, :job_feature, :salary, :working_hours, :holiday_vacation, :job_category, :employment_type, :job_detail, :recommended_comment, :workplace_feature, :corporate_name, :office_name, :institution_type, :work_location, :prefecture, :nearest_station)
    end
end
