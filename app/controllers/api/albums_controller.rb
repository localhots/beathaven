module Api
  class AlbumsController < ::ApplicationController
    def picture
      album = Album.find(params[:id])
      redirect_to album.load_pic
    end

    def show
      album = Album.find(params[:id])
      return render json: { fail: true } if album.nil?

      render json: album.dump_json
    end
  end
end
