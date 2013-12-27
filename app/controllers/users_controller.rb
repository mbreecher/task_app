class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: [:index, :toggle_admin, :toggle_senior, :destroy]
  
  def index
    @users = User.search(params[:search]).order('id asc').paginate(page: params[:page])
  end

  def team_users
    @users = User.where("senior = ?", current_user.id).search(params[:search]).order('id asc').paginate(page: params[:page])
  end

  def toggle_admin
    @user = User.find(params[:id])
    if !current_user?(@user)
      @user.toggle!(:admin)
      @user.save
      flash[:success] = "Admin status changed"
      redirect_to(users_path)
    else
      flash[:success] = "You cannot revoke your own admin status"
      redirect_to(users_path)
    end
  end

  def toggle_senior
    @user = User.find(params[:id])
      @user.toggle!(:is_senior)
      @user.save
      flash[:success] = "Senior status changed"
      redirect_to(users_path)
  end

  def show
    if current_user?(User.find(params[:id])) || current_user.admin?
  	 @user = User.find(params[:id])
    else
      redirect_to(root_url)
    end
  end 
  
  def new
  	@user = User.new
    @seniors = User.where("is_senior = ?",true)
  end

  def edit
    #remove with addition of before_action filter @user = User.find(params[:id])
    @seniors = User.where("is_senior = ?",true)
  end

  def update
    # remove with addition of before_action filter @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      #handle a successful update
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    #let(:tname) {User.find(params[:id]).name}
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_url
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
  		flash[:success] = "User Created"
  		redirect_to user_path(@user)
  	else
  		render 'new'
  	end
  end

  private

  	def user_params
  		params.require(:user).permit(:name, :email, :password, :password_confirmation, :senior)
  	end

    #before filters

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end
    #which is equivalent to:
    #unless signed_in?
    #  flash[:notice] = "Please sign in."
    #  redirect_to signin_url
    #end
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user) || current_user.admin?
    end
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
