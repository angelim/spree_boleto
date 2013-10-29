module Spree
  module Admin
    class BoletoDocsController < Spree::Admin::BaseController
      respond_to :html
      
      def index
        params[:q] ||= {}
        params[:q][:meta_sort] ||= 'due_date.asc'

        @search = Spree::BoletoDoc.ransack(params[:q])

        if !params[:q][:due_date_gt].blank?
          params[:q][:due_date_gt] = Time.zone.parse(params[:q][:due_date_gt]).beginning_of_day rescue ""
        end

        if !params[:q][:due_date_lt].blank?
          params[:q][:due_date_lt] = Time.zone.parse(params[:q][:due_date_lt]).end_of_day rescue ""
        end

        @boleto_docs = Spree::BoletoDoc.ransack(params[:q]).result
          .joins(:order, :payment).includes([:order, :payment])
          .page(params[:page]).per(Spree::Boleto::Configuration[:per_page])
        respond_with(@boleto_docs)
      end
    end
  end
end