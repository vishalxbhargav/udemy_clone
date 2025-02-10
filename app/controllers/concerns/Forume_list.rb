module ForumeList
    def student_forume
        @forumes=[]
        current_user.enrolled_courses.each do |course|
            @forumes<<course.forume
        end
        return @forume
    end
end