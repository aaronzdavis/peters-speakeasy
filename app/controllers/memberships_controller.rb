class MembershipsController < ApplicationController

  # GET /memberships/1
  def show
  end

  # GET /memberships/new
  def new
    @membership = Membership.new
  end

  # POST /memberships
  def create
    @membership = Membership.new(membership_params)
    @membership.email = params[:stripeEmail]

    @amount = 120000

    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :card  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => "Peter's Membership for #{@membership.name}",
      :currency    => 'usd'
    )

    respond_to do |format|
      if @membership.save
        format.html { redirect_to @membership, notice: "Membership was successfully created for #{@membership.name}." }
      else
        format.html { render :new }
      end
    end

  rescue Stripe::CardError => e
    flash[:notice] = e.message
    redirect_to new_membership_path
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def membership_params
      params.require(:membership).permit(:email, :name)
    end
end
