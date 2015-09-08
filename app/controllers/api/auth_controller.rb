module API
  class AuthController < ApplicationController
    def token
      render json: APIKey.create, status: 200
    end
  end
end