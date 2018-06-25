class UsersController < ApplicationController

	get '/users/:slug' do 
        @user = User.find_by_slug(params[:slug])
        erb :'/users/show'
    end
	
	get '/signup' do 
		if logged_in?
			redirect to "/tweets"
		else
		erb :"/users/create_user"
	end
	end

	post '/signup' do 

		if params[:username] != "" && params[:password] !="" && params[:email] != ""
		@user = User.create(params)
		session[:user_id] = @user.id
		redirect to "/tweets"
		else
		redirect to "/signup"
		end
	end

	get '/login' do 

		if !logged_in?

		erb :"users/login"

	else
		redirect to "/tweets"
	end

	end

	post '/login' do 
		@user = User.find_by(username: params[:username])
		
		if @user && @user.authenticate(params[:password])
			session[:user_id] = @user.id 
			redirect to "/tweets"
		else
			redirect to "/login"
		end
	end

	get '/logout' do 
		if logged_in?
		session.clear
		redirect to '/login'
		else
			redirect to '/'
		end
	end





end