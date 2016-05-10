class UsersController < ApplicationController

  def home
    set_current_user
  end

  def sign_up
    if set_current_user
      redirect_to root_path
    end
  end

  def sign_in
    @user = User.find_by(email: params[:email])
    if @user &&  @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Welcome!"
    else
      redirect_to root_path, notice: "Wrong username or password. Try again!"
    end
  end

  def create
    @user = User.new(params.require(:user).permit(:email, :password, :password_confirmation))
    if @user.save
      session[:user_id] = @user.id
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
