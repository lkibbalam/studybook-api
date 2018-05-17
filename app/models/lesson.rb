class Lesson < ApplicationRecord
  belongs_to :course
  has_many :lessons_users, dependent: :destroy
  has_many :students, through: :lessons_users
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :videos, dependent: :destroy
  has_many :tasks, dependent: :destroy
end
