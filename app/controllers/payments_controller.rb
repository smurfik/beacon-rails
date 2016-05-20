class PaymentsController < ApplicationController
  def register
  end

  def create_customer
    Stripe::Customer.create(
      :description => "Customer for test@example.com",
      :source => params[:stripeToken]
    )
    redirect_to root_path, notice: "Customer was created in Stripe"
  end

  def create_charge
    Stripe::Charge.create({
      :amount => 100,
      :currency => "usd",
      :source => params[:stripeToken],
      :description => "Charge for test@example.com"
    })
    redirect_to root_path, notice: "Charge was submitted"
  end
end
