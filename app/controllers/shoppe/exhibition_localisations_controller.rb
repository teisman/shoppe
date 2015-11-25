require "globalize"

module Shoppe
  class ExhibitionLocalisationsController < ApplicationController

    before_filter { @active_nav = :exhibitions }
    before_filter { @exhibition = Shoppe::Exhibition.find(params[:exhibition_id]) }
    before_filter { params[:id] && @localisation = @exhibition.translations.find(params[:id]) }

    def index
      @localisations = @exhibition.translations
    end

    def new
      @localisation = @exhibition.translations.new
      render :action => "form"
    end

    def create
      if I18n.available_locales.include? safe_params[:locale].to_sym
        I18n.locale = safe_params[:locale].to_sym

        if @exhibition.update(safe_params)
          I18n.locale = I18n.default_locale
          redirect_to [@exhibition, :localisations]
        else
          render :action => "form"
        end
      else
        redirect_to [@exhibition, :localisations]
      end
    end

    def edit
      render :action => "form"
    end

    def update
      if @localisation.update(safe_params)
        redirect_to [@exhibition, :localisations]
      else
        render :action => "form"
      end
    end

    def destroy
      @localisation.destroy
      redirect_to [@exhibition, :localisations]
    end

    private

    def safe_params
      params[:exhibition_translation].permit(:name, :locale, :permalink, :description)
    end

  end
end


