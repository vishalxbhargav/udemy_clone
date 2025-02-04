module Motor
    class Ability
      include CanCan::Ability
  
        def initialize(user, _request)
            unless user.nil?
                case user.role
                when 'Admin'
                    can :manage, :all
                when 'Instructor'   
                    can :read, Course,{ user:{ id: user.id } }
                    can :update, Course,exept: [:active]
                    can :read, Chapter,{course:{ user:{ id: user.id } }}
                    can :update, Chapter,{course:{ user:{ id: user.id } }}
                    can :read, Forume,{course:{user:{id:user.id}}}
                    can :update, Forume,{course:{user:{id:user.id}}}
                    can :read, Question,{forume:{course:{user:{id:user.id}}}}
                    can :update, Question,{forume:{course:{user:{id:user.id}}}}
                    can :read, Answer,{question:{forume:{course:{user:{id:user.id}}}}}
                    can :update, Answer,{question:{forume:{course:{user:{id:user.id}}}}}
                    can :read, Comment,{answer:{question:{forume:{course:{user:{id:user.id}}}}}}
                    can :update, Comment,{answer:{question:{forume:{course:{user:{id:user.id}}}}}}
                else 
                    return
                end
            else
                return
            end
        end
    end   
end