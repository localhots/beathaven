module Api
  class ArtistsController < ::ApplicationController
    def show
      artist = Artist.with_name(params[:id].gsub("+", " "))
      return render json: { fail: true } if artist.nil?

      render json: artist.dump_json
    end
  end
end
