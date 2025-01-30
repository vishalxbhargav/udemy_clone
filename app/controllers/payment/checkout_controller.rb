class Payment::CheckoutController < ApplicationController
    skip_before_action :verify_authenticity_token,only: [:create]
    before_action :set_course
    def new
        @course
    end

    def create
        Stripe.api_key = 'sk_test_51Qm7SSHaYe9eIMykVXx4jJLQUrZfa60E0z0IISAcClHbzzf8wMVH3ulJBUEDXxpuCViJIaCxp7wUvvHUsasDBaNs00bNf1j2ww'
        product = Stripe::Product.create({
            name: @course.title,
            "active": true,
        
        })
        price = Stripe::Price.create({
            product: product.id,
            unit_amount: @course.price.to_i*100, 
            currency: "inr",
            metadata: {
                user_id: @course.id,
                course_id: current_user.id,
            },
        })
        session = Stripe::Checkout::Session.create({
            line_items: [{
            price: price,
            quantity: 1,
            }],
            payment_intent_data:{
                "metadata": {
                  "user_id": current_user.id,
                  "course_id": @course.id
                }
            },
            metadata: {couser_id: @course.id},            
            mode: 'payment',
            success_url: student_enrolled_in_course_url(@course),
            cancel_url: payment_cancel_url(@course),
        })
        render json: session.url, status: :ok, allow_other_host: true 
    end

    def success
        @course
    end

    def cancel
        @course
    end
    private 

    def set_course
        @course=Course.find_by(id: params[:id])
        render file: "#{Rails.root}/public/course404.html" if @course.nil?
    end
end
