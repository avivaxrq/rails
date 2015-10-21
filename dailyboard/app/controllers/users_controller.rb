#encoding: utf-8
class UsersController < ApplicationController
  def welcome
    auth = cookies.permanent[:token]
    if (auth == nil)
      @login_boolean = false
    else
      @login_boolean = true
    end
  end

  def signup
  	@user = User.new
  end

  def login
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
  		cookies.permanent[:token] = @user.token
  		redirect_to :task_boards, :notice =>"注册成功"
  	else 
  		render :signup
  	end
  end

  def create_login_session
  	user = User.find_by_name(params[:name])
  	if user && user.authenticate(params[:password])
  		cookies.permanent[:token] = user.token
  		redirect_to :task_boards, :notice => "登陆成功"
  	else flash[:error]="无效的用户名和密码"
  		redirect_to :login
  	end
  end

  def logout
  	cookies.delete(:token)
  	redirect_to root_url, :notice => "已经退出登录"
  end

	private   
	def user_params
		params.require(:user).permit(:name, :password, :password_confirmation, :token)
	end
end
