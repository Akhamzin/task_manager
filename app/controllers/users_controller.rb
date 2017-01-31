class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_client, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  def index
    @users = User.where.not(id: current_user.id)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(client_params)

    if @user.save
      flash[:notice] = "Клиент успешно создан."
      redirect_to @user
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    params[:user].delete(:password) if params[:user][:password].blank?
    params[:user].delete(:password_confirmation) if params[:user][:password].blank? and params[:user][:password_confirmation].blank?
    if @user.update_attributes(client_params)
      flash[:notice] = "Клиент успешно обновлён."
      redirect_to @user
    else
      render :action => 'edit'
    end
  end

  def destroy
    if @user.destroy
      flash[:notice] = "Пользователь успешно удален."
      redirect_to root_path
    end
  end

  private
    def client_params
      params.require(:user).permit(:first_name, :last_name, :middle_name, :company_name, :phone_number, :description, :email, :password)
    end

    def set_client
      @user = User.find(params[:id])
    end

end
