class OrganizationInvitesController < ApplicationController
  helper_method :organization

  def new
  end

  def create
    redirect_to root_path unless UsersOrganization.find_by!(user: current_user, organization: organization).admin?
    if user
      @users_org = UsersOrganization.new(user: user, organization: organization, role: params[:organization_invite][:role].to_i, active: true)
      if @users_org.save
        redirect_to root_path, notice: "Person is invited"
      else
        flash[:notice] = "Person is already part of the organization."
        render :new
      end
    else
      @org_invite = OrganizationInvite.new(params.require(:organization_invite).permit(:email, :role, :organization_id))
      if @org_invite.save
        redirect_to root_path, notice: "Person is invited"
      else
        render :new
      end
    end
  end

  def user
    @user ||= User.find_by(email: params[:organization_invite][:email])
  end

  def organization
    @organization ||= current_user.organizations.find(org_id)
  end

  def org_id
    params[:organization_id] || params[:organization_invite][:organization_id]
  end
end
