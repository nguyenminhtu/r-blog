module Authors
  class AccountsController < ApplicationController
    before_action :authenticate_author!

    def get_update
      @author = current_author
    end

    def update_info
      respond_to do |format|
        if current_author.update(info_params)
          format.html { redirect_to authors_my_account_path, notice: "Account info was updated successfully" }
        else
          format.html { render 'get_update', alert: "Account could not be update !" }
        end
      end
    end

    def update_password
      author = current_author
      respond_to do |format|
        if current_author.valid_password?(params[:author][:current_password])
          author.update(password: params[:author][:password])
          sign_in(author, bypass: true)
          format.html { redirect_to authors_my_account_path, notice: "Account was updated successfully" }
        else
          format.html { render 'get_update', alert: "Wrong password !" }
        end
      end
    end

    def update_avatar
      respond_to do |format|
        if current_author.update(avatar_params)
          format.html { redirect_to authors_my_account_path, notice: "Avatar was updated successfully" }
        else
          format.html { render 'get_update', alert: "Avatar could not be updated" }
        end
      end
    end


    private
    def info_params
      params.require(:author).permit(:name)
    end

    def password_params
      params.require(:author).permit(:current_password, :password, :password_confirmation)
    end

    def avatar_params
      params.require(:author).permit(:avatar)
    end
  end
end
