module Api
  class SearchController < ApplicationController
    def complete
      return render json: { suggestions: [] } if params[:query].to_s.length == 0

      suggestions = (Robbie::Autocomplete.complete(params[:query].to_s) || [])
      render json: {
        query: params[:query],
        suggestions: suggestions
      }
    end

    def wtfis
      result = (Robbie::Autocomplete.search(params[:q].to_s) || []).first
      unless result.nil?
        if result.instance_of? Robbie::Artist
          artist = Artist.find_or_create_by_rovi_id(result.id)
          puts artist.inspect
          unless artist.name?
            artist.import
          end
          return render json: { found: "/artist/#{result.name.gsub(" ", "+")}" }
        elsif result.instance_of? Robbie::Album
          album = Album.find_or_create_by_rovi_id(result.id)
          unless album.title?
            album.import
          end
          return render json: { found: "/album/#{album.id}" }
        end
      end

      render json: { found: nil }
    end
  end
end
