class UserController < ApplicationController

  get '/signup' do
    redirect_if_not_logged_in
    erb :'teams/teams'
  end

  post '/signup' do
    if params[:username] == '' || params[:password] == '' || params[:email] == ''
      redirect to '/signup'
    else
      @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect to '/teams'
    end
  end

  get '/login' do
    redirect_if_not_logged_in
    erb :'teams/teams'
  end

  post '/login' do
    @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to '/teams'
    else
      redirect to '/signup'
    end
  end

  get '/users/:id' do
    @user = User.find_by(:username => params[:username])
    erb :'users/show'
  end

  get '/logout' do
    redirect_if_not_logged_in
    session.destroy
    redirect to '/login'
  end

end
