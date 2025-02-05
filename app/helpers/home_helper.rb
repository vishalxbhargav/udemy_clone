module HomeHelper
    def search_result
        query=params[:query]
        @courses=[]
        if query.empty?
            return @courses
        else
            @courses<<Course.joins(:user).where.like(user:{first_name:["%#{params[:query]}%"]})
            @courses<<Course.where.like(title: ["%#{params[:query]}%"])
            @courses<<Course.joins(:category).where.like(category:{name:["%#{params[:query]}%"]})
            return @courses.flatten.uniq
        end
    end 
end
