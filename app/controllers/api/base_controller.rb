module Api
  class BaseController < ::ApplicationController
    respond_to :json

  private

    def validate_request!
      @user = nil
      render json: { error: "Signature verification failed!" } unless request_valid?

      @user = User.find_by_vk_id(params[:vk_auth][:mid])
    end

    def request_valid?
      %w[ expire mid secret sid sig ].each do |key|
        raise "Parameter not set: #{key} (VK auth)" if params[:vk_auth][key].nil?
      end

      validation_string = %w[ expire mid secret sid ].map{ |key|
        "#{key}=#{params[:vk_auth][key]}"
      }.join() << BeatHaven::Application.config.api_accounts["vk"]["api_secret"]

      params[:vk_auth][:sig] == Digest::MD5.hexdigest(validation_string)
    end

  end
end
