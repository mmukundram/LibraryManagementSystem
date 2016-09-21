class AdminsController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    if !logged_in?
      flash.now[:danger] = 'You are not logged in. Please login to continue.'
    elsif !current_user.admin
      flash.now[:danger] = 'You are not authorized to view this page.'
    else
      @users = User.all
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    if !logged_in?
      flash.now[:danger] = 'You are not logged in. Please login to continue.'
    elsif !current_user.admin
      flash.now[:danger] = 'You are not authorized to view this page.'
    else
      @user = User.find(params[:id])
    end
  end

  # GET /users/new
  def new
    if !logged_in?
      flash.now[:danger] = 'You are not logged in. Please login to continue.'
    elsif !current_user.admin
      flash.now[:danger] = 'You are not authorized to view this page.'
    else
      @user = User.new
    end
  end

  # GET /users/1/edit
  def edit
    if !logged_in?
      flash.now[:danger] = 'You are not logged in. Please login to continue.'
    else
      @user = User.find(params[:id])
      if @user.email != current_user.email
        flash.now[:danger] = "You cannot edit another admin's profile."
        @user = nil
      end
    end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    @user.admin = true
    @user.removable = true
    @user.privilege = false
    if @user.save
      redirect_to admins_path(@user), notice: 'Admin was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    flag = false
    if @user.email == current_user.email
      flag = true
    end
    if @user.update(user_params)
      @user.admin = true
      @user.removable = true
      if flag
        log_out
        log_in(@user)
      end
      redirect_to admin_path(@user), notice: 'Admin was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    if @user.removable
      if @user.email != current_user.email
        @user.destroy
        redirect_to admin_url, notice: 'Admin was successfully destroyed.'
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:email, :name, :password, :address, :phone, :admins, :removable, :privilege)
  end
end
