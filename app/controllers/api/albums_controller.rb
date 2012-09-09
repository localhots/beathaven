module Api
  class AlbumsController < BaseController
    def picture
      album = Album.find(params[:id])
      redirect_to album.load_pic
    end

    def show
      @album = Album.find(params[:id])
      return render json: { fail: true } if @album.nil?
    end
  end
end
