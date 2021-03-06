# frozen_string_literal: true

module Api
  module V1
    class NotificationsController < ApplicationController
      def index
        @notifications = current_user.notifications.unseen.order("created_at desc")
        respond_with(@notifications)
      end

      def update
        @notification = Notification.find(params[:id])
        authorize @notification
        @notification.update(status: :seen)
        render json: @notification
      end
    end
  end
end
