class OrganizationInvitesController < ApplicationController
  helper_method :organization, :org_invite

  def new
  end

  def create
    redirect_to root_path unless UsersOrganization.find_by!(user: current_user, organization: organization).admin?
    if user
      if users_org.save
        redirect_to root_path, notice: "Person is invited"
      else
        flash[:notice] = "Person is already part of the organization."
        render :new
      end
    else
      if org_invite.save
        redirect_to root_path, notice: "Person is invited"
      else
        render :new
      end
    end
  end

  def user
    @user ||= User.find_by(email: params[:organization_invite][:email].downcase)
  end

  def organization
    @organization ||= current_user.organizations.find(org_id)
  end

  def org_id
    params[:organization_id] || params[:organization_invite][:organization_id]
  end

  def users_org
    @users_org = UsersOrganization.new(
      user: user,
      organization: organization,
      role: params[:organization_invite][:role],
      active: true
    )
  end

  def org_invite
    @org_invite = OrganizationInvite.new(params.require(:organization_invite).permit(:email, :role, :organization_id))
  end
end
