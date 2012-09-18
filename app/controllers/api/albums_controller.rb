module Api
  class AlbumsController < BaseController
    before_filter :validate_request!

    def picture
      album = Album.find(params[:id])
      redirect_to album.update_image.sized(:extralarge)
    end

    def show
      @album = Album.find(params[:id])
      return render json: { fail: true } if @album.nil?
    end

  end
end
