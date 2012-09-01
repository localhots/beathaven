module Api
  class SessionController < ApplicationController

    def auth
      render json: { error: "Signature verification failed!" } unless request_valid?

      user_name = "#{params[:user][:first_name]} #{params[:user][:last_name]}"

      user = User.find_by_vk_id(params[:mid].to_i)
      is_newbie = false
      if user.nil?
        user = User.create(name: user_name, vk_id: params[:mid].to_i)
        is_newbie = true
      elsif user.name != user_name
        user.update_attributes(name: user_name)
      end

      render json: { user: user.dump_json, is_newbie: is_newbie }
    end

  private

    def request_valid?
      %w[ expire mid secret sid sig ].map(&:to_sym).each do |key|
        raise "Parameter not set: #{key}" if params[key].nil?
      end

      validation_string = %w[ expire mid secret sid ].map{ |key|
        "#{key}=#{params[key.to_sym]}"
      }.join() << BeatHaven::Application.config.api_accounts["vk"]["api_secret"]

      params[:sig] == Digest::MD5.hexdigest(validation_string)
    end

  end
end
