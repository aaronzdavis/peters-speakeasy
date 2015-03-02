class MembershipsController < ApplicationController

  def guestlist
    @members = Membership.unscoped.order(:name).active_members

    @inactive_members = Membership.created_before(1.year.ago)
  end

  # GET /memberships/1
  def show
  end

  # GET /memberships/new
  def new
    # byebug
    @membership = Membersship.new

    logger.debug "\n--\nMembership.default_fee: #{Membership.default_fee}\n--\n"

  end

  # POST /memberships
  def create
    logger.debug "\n--\n membership_params: #{membership_params.inspect} \n--"

    @membership = Membership.new(membership_params)

    logger.debug "\n--\n New membership: #{@membership.attributes.inspect} \n--"

    @membership.email = params[:stripeEmail]

    @amount = Membership.default_fee

    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :card  => params[:stripeToken]
    )

    logger.debug "\n--\n New Stripe Customer: #{customer.inspect} \n--"

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => "Peter's Membership for #{@membership.name}",
      :currency    => 'usd'
    )

    logger.debug "\n--\n New Stripe Charge: #{charge.inspect} \n--\n"

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
