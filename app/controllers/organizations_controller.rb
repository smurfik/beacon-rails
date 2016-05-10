class OrganizationsController < ApplicationController

  def create
    set_current_user
    @organization = Organization.new(params.require(:organization).permit(:name))
    if @organization.save
      UsersOrganization.create!(user: @current_user, organization: @organization, role: "admin", active: true)
      redirect_to root_path, notice: "The organization was created"
    else
      @users_organizations = @current_user.users_organizations.includes(:organization)
      render 'users/home'
    end
  end
end
