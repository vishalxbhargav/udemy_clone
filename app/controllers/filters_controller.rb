class FiltersController < ApplicationController
    before_action :set_category
    def show
        @pagy, @courses = pagy(@category.courses)
        @category
    end
    private
    
    def set_category
        @category=Category.find_by(id: params[:id])
        render file: "#{Rails.root}/public/404.html",layout: false if @category.nil?
    end

end
