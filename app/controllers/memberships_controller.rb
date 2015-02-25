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

    respond_to do |format|
      if @membership.save
        format.html { redirect_to @membership, notice: 'Membership was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def membership_params
      params.require(:membership).permit(:email, :name)
    end
end
