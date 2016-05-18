class OrganizationInvitesController < ApplicationController

  def new
    @organization ||= current_user.organizations.find(params[:organization_id])
  end

  def create
    @organization ||= current_user.organizations.find(params[:organization_invite][:organization_id])
    redirect_to root_path unless UsersOrganization.find_by!(user: current_user, organization: @organization).admin?
    @user ||= User.find_by(email: params[:organization_invite][:email].downcase)
    if @user
      add_to_org
    else
      create_org_invite
    end
  end

  def add_to_org
    @users_org = UsersOrganization.new(
      user: @user,
      organization: @organization,
      role: params[:organization_invite][:role],
      active: true
    )
    if @users_org.save
      redirect_to root_path, notice: "Person is invited"
    else
      flash[:notice] = "Person is already part of the organization."
      render :new
    end
  end

  def create_org_invite
    @org_invite = OrganizationInvite.new(params.require(:organization_invite).permit(:email, :role, :organization_id))
    if @org_invite.save
      redirect_to root_path, notice: "Person is invited"
    else
      render :new
    end
  end
end
