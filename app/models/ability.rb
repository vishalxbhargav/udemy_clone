# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    unless user.nil?
        case user.role
          when 'Admin'
              can :manage, :all
          when 'Instructor'   
              can :create, Course
              can :read, Course,{ user:{ id: user.id } }
              can :update, Course,{ user:{ id: user.id } }
              can :delete, Course,{ user:{ id: user.id } }
              can :read, Chapter,{course:{ user:{ id: user.id } }}
              can :update, Chapter,{course:{ user:{ id: user.id } }}
              can :create, Chapter
              can :create, Forume,{course:{user:{id:user.id}}}
              can :read, Forume,{course:{user:{id:user.id}}}
              can :update, Forume,{course:{user:{id:user.id}}}
              can :manage, Verifycation
          else 
              can :read,Progre,{Enrollment:{user:{id:user.id}}}
              can :update,Progre,{Enrollment:{user:{id:user.id}}}
              can :read,Forume do |forume|
                user.enrolled_courses&.any?forume.course
              end
              can [:read,:create,:update],Question do |question|
                user.enrolled_courses&.any?question.forume.course
              end
          end
      else
        return
    end
  end
end
