class UserController < ApplicationController
    before_action :authorize_request, except: :createUser
    def getAllUser
        puts(params[:id]) 
        if (params[:id])
            users = User.find(params[:id])
        elsif(params[:type])
            puts(params[:type])
            if (params[:type] == "owner")
                users = User.where(role_id: 3) 
            elsif (params[:type] == "emp")
                users = User.where(role_id: 2) 
            else
                users = User.where(role_id: 1) 
            end
        else
            users = User.all 
        end
        render json: users, status: :ok
    end
    def checkValid
        render json: "Authorized", status:  :ok
    end
    skip_before_action :verify_authenticity_token 
    def getUserByEmailPassword
        email = params[:email]
        password = params[:password]
        puts(email, password)
        user = User.find_by(email: email)
        if (user && user.authenticate(password))
            render json: user, status: :ok
        else 
            render html: "You are not authorized", status: :unauthorized
        end
    end
    def createUser
        role = Role.find(1)
        params[:image] = params[:image].to_json
        user = User.create(params.permit(:first_name, :last_name, :mobile, :email, :intro, :image, :status, :password))
        user.role = role
        if (user.save())
            render json: "User Created Successfully", status: :created
        else
            render json: user.errors.full_messages, status: :bad_request
        end
    end
    def updateUser
        ok = User.find(params[:id])
        puts(json: ok)
        puts("this is json data", ok)
        user = User.find(params[:id]).update(params.permit(:first_name, :last_name, :mobile, :email, :intro, :image, :status, :password))
        # puts("user", user.errors.full_messages)
        if (user)
            render json: "User Updated Successfully", status: :created
        else
            render json: "Something went wrong", status: :bad_request
        end
    end
    def deleteUser
        user = User.find(params[:id])
        if (user)
            user.delete
            render json: "User deleted Successfully", status: :no_content
        else 
            render json: "Something went wrong", status: :bad_request
        end
    end
end
