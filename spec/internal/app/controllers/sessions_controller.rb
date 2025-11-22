# frozen_string_literal: true

class SessionsController < ActionController::Base
  # OmniAuth callback - successful authentication
  def create
    auth = request.env["omniauth.auth"]
    render json: {provider: auth["provider"], uid: auth["uid"]}, status: :ok
  end

  # OmniAuth failure
  def failure
    render json: {error: params[:message] || "failure"}, status: :unauthorized
  end
end

