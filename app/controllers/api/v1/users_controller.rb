# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      before_action :set_team, only: %i[index create]
      before_action :set_user, only: %i[show update destroy]

      def current
        render json: current_user.as_json(only: %i[id email first_name last_name phone role], methods: :courses_users)
      end

      def all
        respond_with(@users = User.where(mentor: current_user))
      end

      def show
        respond_with(@user.as_json(only: %i[id email first_name last_name phone role], methods: :courses))
      end

      def index
        respond_with(@users = @team.users)
      end

      def create
        @user = @team.users.create(set_params)
        render json: @user
      end

      def update
        binding.pry
        @user.avatar.attach(params.dig(:user, :avatar))
      end

      def destroy
        @user.delete
      end

      private

      def set_user
        @user = User.find(params[:id])
      end

      def set_team
        @team = Team.find(params[:team_id])
      end

      def set_params
        params.require(:user).permit(:first_name,
                                     :last_name, :phone, :email, :password, :status, :role, :avatar, :github_url)
      end

      def set_update_params
        params.require(:user).permit(:first_name, :last_name, :phone, :password, :avatar, :github_url)
      end
    end
  end
end
