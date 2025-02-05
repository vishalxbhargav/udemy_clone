class HomeController < ApplicationController
    include HomeHelper
    def index
    end
    
    def search
        @courses=search_result
        render partial: "components/search_result", locals:{courses: @courses}
    end

    def search_page
    end

end