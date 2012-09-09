module Api
  class ArtistsController < BaseController
    def show
      @artist = Artist.with_name(params[:id].gsub("+", " "))
      return render json: { fail: true } if @artist.nil?
    end
  end
end
