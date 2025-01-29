class Payment::CheckoutController < ApplicationController
    skip_before_action :verify_authenticity_token,only: [:create]
    before_action :set_course
    def new
        @course
    end

    def create
        Stripe.api_key = 'sk_test_51Qm7SSHaYe9eIMykVXx4jJLQUrZfa60E0z0IISAcClHbzzf8wMVH3ulJBUEDXxpuCViJIaCxp7wUvvHUsasDBaNs00bNf1j2ww'
        price = Stripe::Price.create({
            product: "prod_Rfrb9CCrYUSSlK",
            unit_amount: 1000, 
            currency: "usd"
        })
        session = Stripe::Checkout::Session.create({
            line_items: [{
            price: price,
            quantity: 1,
            }],
            mode: 'payment',
            success_url: "http://localhost:3000"+ '/success.html',
            cancel_url: "http://localhost:3000" + '/cancel.html',
        })
        render json: session.url, status: :ok, allow_other_host: true 
    end

    private 

    def set_course
        @course=Course.find_by(id: params[:id])
        render file: "#{Rails.root}/public/course404.html" if @course.nil?
    end
end
