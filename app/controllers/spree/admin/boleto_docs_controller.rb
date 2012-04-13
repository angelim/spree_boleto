module Spree
  module Admin
    class BoletoDocsController < Spree::Admin::BaseController
      respond_to :html
      
      def index
        params[:search] ||= {}
        params[:search][:meta_sort] ||= 'due_date.asc'

        @search = Spree::BoletoDoc.metasearch(params[:search])

        if !params[:search][:due_date_greater_than].blank?
          params[:search][:due_date_greater_than] = Time.zone.parse(params[:search][:due_date_greater_than]).beginning_of_day rescue ""
        end

        if !params[:search][:due_date_less_than].blank?
          params[:search][:due_date_less_than] = Time.zone.parse(params[:search][:due_date_less_than]).end_of_day rescue ""
        end

        @boleto_docs = Spree::BoletoDoc.metasearch(params[:search]).includes([:order, :payment]).page(params[:page]).per(Spree::Config[:orders_per_page])
        respond_with(@boleto_docs)
      end
    end
  end
end