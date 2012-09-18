module Api
  class SessionController < BaseController
    before_filter :validate_request!

    def auth
      user_name = "#{params[:user][:first_name]} #{params[:user][:last_name]}"

      is_newbie = false
      if @user.nil?
        @user = User.create(name: user_name, vk_id: params[:vk_auth][:mid].to_i)
        is_newbie = true
      elsif @user.name != user_name
        @user.update_attributes(name: user_name)
      end

      render json: { user: @user.dump_json, is_newbie: is_newbie }
    end

  end
end
