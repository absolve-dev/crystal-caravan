class Payment < ActiveRecord::Base
  
  enum status: [
    :failed,
    :authorized,
    :captured,
    :refunded
  ]
  
  belongs_to :order
  
  def stripe_params(params)
    errors = []
    
    attributes = {
      :card_number => "Card number",
      :card_exp_month => "Card expiration month",
      :card_exp_year => "Card expiration year",
      :card_cvc => "Card CVC"
    }
    
    # fail on regex match, check for only numbers
    attributes.each do |key, value|
      if !params[key] || params[key] == ""
        errors << "#{params[key]} is empty."
      elsif not params[key] =~ /^[\d]+$/
        errors << "#{value} is invalid."
      end
    end
    
    constructed_params = {
      :amount => (self.order.total * 100).to_i,
      :order_id => self.order.id,
      :exp_month => params[:card_exp_month],
      :exp_year => params[:card_exp_year],
      :card_number => params[:card_number],
      :cvc => params[:card_cvc],
      :full_name => "#{params[:first_name_billing]} #{params[:last_name_billing]}",
      :zip_code => params[:zip_billing]
    }
    
    errors.length > 0 ? errors.join(" ") : constructed_params
  end
  
  def stripe_create(options)
    charge = Stripe::Charge.create({
      :amount => options[:amount],
      :currency => "usd",
      :capture => false,
      :description => "Order Number #{options[:order_id]}",
      :source => {
        :exp_month => options[:exp_month],
        :exp_year => options[:exp_year],
        :number => options[:card_number],
        :cvc => options[:cvc],
        :name => options[:full_name],
        :address_zip => options[:zip_code]
      }
    })
    self.update(:stripe_charge_id => charge[:id], :gateway => "stripe")
    
    if charge[:status] == "succeeded"
      self.update(:status => :authorized)
      return true
    else
      self.update(:status => :failed, :response_message => charge[:failure_message])
      return false
    end
  end
  
  def stripe_capture
    charge = Stripe::Charge.retrieve(self.stripe_charge_id)
    charge.capture
  end
  
  def stripe_refund
    refund = Stripe::Refund.create( :charge => self.stripe_charge_id )
    self.update(:stripe_refund_id => refund.id)
  end
  
end
