class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
      if @user.save
        session[:user_id] = @user.id
        redirect_to root_path
      else
        render :new, notice: "No ha sido posible crear el usuario."
      end
  end

  def show
    @user = User.includes(:stories).find(helpers.current_user.id)
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
