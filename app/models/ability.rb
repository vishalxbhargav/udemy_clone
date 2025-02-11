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
              can :read, Chapter
              can :update, Chapter,{course:{ user:{ id: user.id } }}
              can :create, Chapter
              can :read, Forume,{course:{user:{id:user.id}}}
              can :update, Forume,{course:{user:{id:user.id}}}
              can :manage, Verifycation
          else 
              can :read,Course
              can :read,Chapter
              can :read,Transaction
              return
          end
      else
        return
    end
  end
end
