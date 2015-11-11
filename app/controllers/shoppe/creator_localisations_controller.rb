require "globalize"

module Shoppe
  class CreatorLocalisationsController < ApplicationController

    before_filter { @active_nav = :creators }
    before_filter { @creator = Shoppe::Creator.find(params[:creator_id]) }
    before_filter { params[:id] && @localisation = @creator.translations.find(params[:id]) }

    def index
      @localisations = @creator.translations
    end

    def new
      @localisation = @creator.translations.new
      render :action => "form"
    end

    def create
      if I18n.available_locales.include? safe_params[:locale].to_sym
        I18n.locale = safe_params[:locale].to_sym

        if @creator.update(safe_params)
          I18n.locale = I18n.default_locale
          redirect_to [@creator, :localisations]
        else
          render :action => "form"
        end
      else
        redirect_to [@creator, :localisations]
      end
    end

    def edit
      render :action => "form"
    end

    def update
      if @localisation.update(safe_params)
        redirect_to [@creator, :localisations]
      else
        render :action => "form"
      end
    end

    def destroy
      @localisation.destroy
      redirect_to [@creator, :localisations]
    end

    private

    def safe_params
      params[:product_translation].permit(:name, :locale, :permalink, :description, :short_description)
    end

  end
end

