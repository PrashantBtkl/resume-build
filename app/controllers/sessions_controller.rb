class SessionsController < ApplicationController
  
    def new
    end
  
    def create
        user = User.find_by(email: params[:session][:email].downcase)
        if user && user.authenticate(params[:session][:password])
            log_in(user)
            redirect_to(root_path)
        else
            flash.now[:danger] = 'Invalid email/password combination'
            render('new')
        end
    end

    def new_user
        render('signup')
    end

    def signup
        user = User.create({name: params[:session][:username], email: params[:session][:email], password: params[:session][:password]})
        if user.valid?
            user.profile = Profile.new
            user.profile.save
            user.profile.educations.create
            render('new')
        else
            flash.now[:danger] = 'Failed to create new user'
            render('signup')
        end
    end
  
    def destroy
        log_out
        redirect_to(root_url)
    end

end
