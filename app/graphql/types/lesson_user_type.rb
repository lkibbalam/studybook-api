# frozen_string_literal: true

module Types
  class LessonUserType < BaseObject
    field :id, ID, null: false
    field :user, UserType, null: false
    field :lesson, LessonType, null: false
    field :mark, Int, null: false
    field :status, String, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end