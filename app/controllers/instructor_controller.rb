class InstructorController < ApplicationController
    before_action :authenticate_user!
    layout "instructor"
    def index 
    end

    def dashboard
    end

    def my_earnig

    end
    
end