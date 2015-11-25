module Shoppe
  class ExhibitionsController < Shoppe::ApplicationController

    before_filter { @active_nav = :exhibitions }
    before_filter { params[:id] && @exhibition = Shoppe::Exhibition.find(params[:id]) }

    def index
      @exhibitions = Shoppe::Exhibition.includes(:translations).order(:name)
    end

    def new
      @exhibition = Shoppe::Exhibition.new
    end

    def create
      @exhibition = Shoppe::Exhibition.new(safe_params)
      if @exhibition.save
        redirect_to :exhibitions
      else
        render :action => "new"
      end
    end

    def edit
    end

    def update
      if @exhibition.update(safe_params)
        redirect_to [:edit, @exhibition]
      else
        render :action => "edit"
      end
    end

    def destroy
      @exhibition.destroy
      redirect_to :exhibitionss
    end

    private

    def safe_params
      file_params = [:file, :parent_id, :role, :parent_type, file: []]
      params[:exhibition].permit(:name, :permalink, :description, :attachments => [avatar: file_params, extra: file_params])
    end

  end
end


