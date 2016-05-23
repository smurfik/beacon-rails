class PaymentsController < ApplicationController
  before_action :require_admin, only: :create_customer

  def register
  end

  def create_customer
    if @organization.stripe_id.blank?
      @response = Stripe::Customer.create(
        :description => "Customer for test@example.com",
        :source => params[:stripeToken]
      )
      @organization.update!(stripe_id: @response.id)
      redirect_to root_path, notice: "Customer was created in Stripe"
    else
      redirect_to root_path, notice: "Organization already has a credit card"
    end
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

  def require_admin
    @organization ||= current_user.organizations.find(params[:organization_id])
    redirect_to root_path unless UsersOrganization.find_by!(user: current_user, organization: @organization).admin?
  end
end
