module Api
  class ArtistsController < BaseController
    before_filter :validate_request!

    def show
      @artist = Artist.with_name(params[:id].gsub("+", " "))
      return render json: { fail: true } if @artist.nil?
    end

  end
end
