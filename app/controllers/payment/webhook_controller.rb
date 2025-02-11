class Payment::WebhookController < ApplicationController
    skip_before_action :verify_authenticity_token

    def create
        endpoint_secret=ENV['stripe_endpoint_secret']
        payload = request.body.read
        event = nil

        begin
            event = Stripe::Event.construct_from(
            JSON.parse(payload, symbolize_names: true)
            )
        rescue JSON::ParserError => e
            # Invalid payload
            puts "⚠️  Webhook error while parsing basic request. #{e.message}"
            status 400
            return
        end
        # Check if webhook signing is configured.
        if endpoint_secret
            # Retrieve the event by verifying the signature using the raw body and secret.
            signature = request.env['HTTP_STRIPE_SIGNATURE'];
            begin
            event = Stripe::Webhook.construct_event(
                payload, signature, endpoint_secret
            )
            rescue Stripe::SignatureVerificationError => e
            puts "⚠️  Webhook signature verification failed. #{e.message}"
            status 400
            end
        end
        # Handle the event
        case event.type
        when 'payment_intent.succeeded' 
            payment_intent = event.data.object # contains a Stripe::PaymentIntent
            puts "Payment for #{payment_intent['amount']} succeeded."
            amount=event[:data][:object][:amount]/100
            Order.create(course_id:event[:data][:object][:metadata][:course_id] ,user_id: event[:data][:object][:metadata][:user_id],transaction_id: event[:data][:object][:id],status:1,amount: amount)
        when "payment_intent.payment_failed"
            amount=event[:data][:object][:amount]/100
            Order.create(course_id:event[:data][:object][:metadata][:course_id] ,user_id: event[:data][:object][:metadata][:user_id],transaction_id: event[:data][:object][:id],amount: amount)
        when 'payment_method.attached'
            payment_method = event.data.object
        when 'checkout.session.completed'
        else
            puts "Unhandled event type: #{event.type}"
        end
        status 200
    end
end