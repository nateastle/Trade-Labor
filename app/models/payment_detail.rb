class PaymentDetail < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible  :ip_address, :user_id, :first_name , :last_name , :card_type ,:card_number,:card_verification,:card_expires_on

  attr_accessor :card_number, :card_verification

  belongs_to :user

  #has_many :transactions, :class_name => "PaymentTransaction"

  # validate :validate_card, :on => :create

  def payment_success?
    debugger
    if credit_card.valid?
  	    response = GATEWAY.purchase(price_in_cents, credit_card, purchase_options)
  	    #transactions.create!(:action => "purchase", :amount => price_in_cents, :response => response)
  	    #user.update_attribute(:active, true) if response.success?

  	   if !response.success?
          errors.add :base, "Invalid Card Detail"
          false
       else
          true
       end 
  	else
  	    credit_card.errors.full_messages.each do |message|
             errors.add :base, message
          end
  	    false	
  	end 
  	rescue Exception => e
  	   errors.add :base, "Error in Payment #{e.message}"
       false
  end
  
  def price_in_cents
    (180*100).round
  end


  def validate_card
    unless credit_card.valid?
      credit_card.errors.full_messages.each do |message|
        errors.add :base, message
      end
    end
  end

  private
  
  def purchase_options
    {
      :ip => ip_address,
      :billing_address => {
        :name     => "sandeep sharma",
        :address1 => "fdgfdg",
        :city     => "gdfgdg",
        :state    => "Madhya Pradesh",
        :country  => "IN",
        :zip      => "452001"
      }
    }
  end
  
  
  def credit_card
    @credit_card ||= ActiveMerchant::Billing::CreditCard.new(
      :type               => 'Visa',
      :number             => card_number,
      :verification_value => card_verification,
      :month              => card_expires_on.month,
      :year               => card_expires_on.year,
      # :first_name         => first_name.split(" ")[0],
      # :last_name          => last_name.split(" ")[1]
      :first_name         => first_name,
      :last_name          => last_name
    )
  end 
end
