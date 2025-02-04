class Forume::ForumesController < ApplicationController
    layout "forume"
    before_action :authenticate_user!
    before_action :set_forume

    def show
        @forume
    end

    private

    def set_forume
        @forume=Forume.find_by(id: params[:id])
        render file: "#{Rails.root}/public/course404.html" if @forume.nil?
    end
end