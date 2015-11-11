module Shoppe
  class CreatorsController < Shoppe::ApplicationController

    before_filter { @active_nav = :creators }
    before_filter { params[:id] && @creator = Shoppe::Creator.find(params[:id]) }

    def index
      @creators = Shoppe::Creator.includes(:translations).order(:name)
    end

    def new
      @creator = Shoppe::Creator.new
    end

    def create
      @creator = Shoppe::Creator.new(safe_params)
      if @creator.save
        redirect_to :creators
      else
        render :action => "new"
      end
    end

    def edit
    end

    def update
      if @creator.update(safe_params)
        redirect_to [:edit, @creator]
      else
        render :action => "edit"
      end
    end

    def destroy
      @creator.destroy
      redirect_to :creators
    end

    private

    def safe_params
      file_params = [:file, :parent_id, :role, :parent_type, file: []]
      params[:creator].permit(:name, :email, :website, :permalink, :description, :short_description, :attachments => [avatar: file_params, extra: file_params])
    end

  end
end

