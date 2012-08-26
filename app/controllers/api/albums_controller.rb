module Api
  class AlbumsController < ::ApplicationController
    def picture
      album = Album.find(params[:id])
      redirect_to album.load_pic
    end
  end
end
