class ChargesController < ApplicationController
  before_action :authenticate_user! 
   
  def new 
    
    if current_user.premium? || current_user.admin?
      flash[:alert] = "You already have a premium level account!"
      redirect_to root_path
    end
    
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Mudonymous Membership - #{current_user.username}",
      amount: ChargesHelper.default_charge_amount
    }
  end  
  
  def create
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )
 
  
    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: ChargesHelper.default_charge_amount,
      description: "Mudonymous Membership - #{current_user.email}",
      currency: "usd"
      )
      
    current_user.premium!
    flash[:notice] = "You have successfully upgraded to a Mudonymous Premium Membership!"
    redirect_to root_path
    
    rescue Stripe::CardError => e
     flash[:alert] = e.message
     redirect_to new_charge_path
  end
    
end