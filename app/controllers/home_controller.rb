class HomeController < ApplicationController
    include HomeHelper
    def index
        @pagy, @courses = pagy(Course.all, items:5)
    end
    
    def search
        @courses=search_result
        render partial: "components/search_result", locals:{courses: @courses}
    end

    def search_page
    end

end