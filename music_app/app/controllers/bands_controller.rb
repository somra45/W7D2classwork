class BandsController < ApplicationController
    def index
        @bands = Band.all

        render :index
    end

    def create
        @band = Band.new(band_params)

        if @band.save
            flash[:messages] = "Band was successfully created."
            redirect_to band_url(@band) 
        else
            render :new
        end
    end

    def show
        @band = Band.find(params[:id])

        if @band
            render :show
        else
            flash[:messages] = "Band not found."
            redirect_to bands_url
        end
    end

    def destroy
        @band = Band.find(params[:id])

        @band.destroy

        redirect_to bands_url
    end

    def new
        @band = Band.new

        render :new
    end

    def update
        
    end

    def edit

    end

    def band_params
        params.require(:band).permit(:name)
    end
end