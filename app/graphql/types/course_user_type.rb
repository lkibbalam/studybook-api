# frozen_string_literal: true

module Types
  class CourseUserType < BaseObject
    guard ->(course_user, _args, ctx) { CoursesUserPolicy.new(ctx[:me], course_user.object).show? }
    field :id, ID, null: false
    field :student, UserType, null: false
    field :course, CourseType, null: false
    field :status, String, null: false
    field :mark, Int, null: false
    field :progress, Int, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
