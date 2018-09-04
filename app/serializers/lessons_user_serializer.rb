# frozen_string_literal: true

class LessonsUserSerializer < ActiveModel::Serializer
  attributes %i[status lesson tasks course lessons student_id video poster tasks_user course_lessons_user]

  def lesson
    object.lesson
  end

  def tasks
    lesson.tasks
  end

  def course
    lesson.course
  end

  def lessons
    course.lessons
  end

  def course_lessons_user
    LessonsUser.where(student: object.student, lesson: object.lesson.course.lessons)
  end

  def video
    Rails.application.routes.url_helpers.rails_blob_url(lesson.video) if lesson.video.attached?
  end

  def poster
    Rails.application.routes.url_helpers.rails_blob_url(lesson.poster) if lesson.poster.attached?
  end

  def tasks_user
    TasksUser.where(task: tasks, user: object.student).map do |task_user|
      TasksUserSerializer.new(task_user)
    end
  end
end
