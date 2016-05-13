class OrganizationInvitesController < ApplicationController
  def new
    @organization = Organization.find(params[:organization_id])
  end

  def create
    @user = User.find_by(email: params[:organization_invite][:email])
    if !@user
      @org_invite = OrganizationInvite.new(params.require(:organization_invite).permit(:email, :role, :organization_id))
      if @org_invite.save
        redirect_to root_path, notice: "Person is invited"
      else
        @organization = Organization.find(params[:organization_invite][:organization_id])
        render :new
      end
    else
      @users_org = UsersOrganization.new(user: @user, organization_id: params[:organization_invite][:organization_id], role: params[:organization_invite][:role].to_i, active: true)
      if @users_org.save
        redirect_to root_path, notice: "Person is invited"
      else
        @organization = Organization.find(params[:organization_invite][:organization_id])
        render :new
        flash[:notice] = "Person is already part of the organization."
      end
    end
  end
end
