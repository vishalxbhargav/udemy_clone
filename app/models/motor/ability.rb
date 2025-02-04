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
                    can :read, Chapter
                    can :update, Chapter
                    can :read, Forume,{course:{user:{id:user.id}}}
                    can :update, Forume,{course:{user:{id:user.id}}}
                    can :read, Question
                    can :update, Question
                    can :read, Answer
                    can :update, Answer
                    can :read, Comment
                    can :update, Comment
                else 
                    return
                end
            else
                return
            end
        end
    end   
end