class UsersController < ApplicationController

  def home
    if current_user
      @users_organizations = current_user.users_organizations.includes(:organization)
    end
  end

  def sign_up
    @user = User.new
    if current_user
      redirect_to root_path
    end
  end

  def sign_in
    @user = User.find_by(email: params[:user][:email])
    if @user &&  @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Welcome!"
    else
      redirect_to root_path, notice: "Wrong username or password. Try again!"
    end
  end

  def create
    @user = User.new(params.require(:user).permit(:email, :first_name, :last_name, :password, :password_confirmation))
    if @user.save
      session[:user_id] = @user.id
      @org_invites = OrganizationInvite.where("email = ? and created_at >= ?", @user.email, 1.week.ago)
      if @org_invites.exists?
        @org_invites.each do |org_invite|
          UsersOrganization.create!(user: @user, organization_id: org_invite.organization_id, role: org_invite.role, active: true)
        end
      end
      redirect_to root_path
    else
      render :sign_up
    end
  end

  def sign_out
    session.delete(:user_id)
    redirect_to root_path, notice: "See you soon!"
  end
end
