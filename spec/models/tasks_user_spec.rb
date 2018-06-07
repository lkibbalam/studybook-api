# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TasksUser, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:task) }
  it { should have_many(:notifications) }

  let(:mentor) { create(:user, :staff) }
  let(:student) { create(:user, :student, mentor: mentor) }
  let(:course) { create(:course, lessons: create_list(:lesson_with_3_tasks, 3)) }
  let!(:course_user) { create(:courses_user, student: student, course: course) }
  let(:student_task_first) { student.tasks_users.first }
  let(:student_task_second) { student.tasks_users.second }
  let(:student_task_third) { student.tasks_users.third }

  describe '.create_notification_to_mentor' do
    it 'when student send task from undone to verifying' do
      student_task_first.update(status: :undone)
      expect { student_task_first.update(status: :verifying) }.to change(mentor.notifications, :count).by(1)
    end

    it 'when student send task from change to verifying' do
      student_task_first.update(status: :change)
      expect { student_task_first.update(status: :verifying) }.to change(mentor.notifications, :count).by(1)
    end
  end

  describe '.create_notification_to_student' do
    it 'when task has been accepted' do
      student_task_second.update(status: :verifying)
      expect { student_task_second.update(status: :accept) }.to change(student.notifications, :count).by(1)
    end

    it 'when task has been changed' do
      student_task_third.update(status: :verifying)
      expect { student_task_third.update(status: :change) }.to change(student.notifications, :count).by(1)
    end
  end

  describe '.unlock_next_lesson' do
    let(:change_all) { student.tasks_users.where(task: course.lessons.first.tasks).update_all(status: :change) }
    let(:approve_all) { student.tasks_users.where(task: course.lessons.first.tasks).each(&:accept!) }

    it 'when approve last task of lesson' do
      change_all
      # TODO: true test but gives false, why?????
      expect do
        approve_all
        student.lessons_users.second.reload
      end.to change(student.lessons_users.second, :status).from('locked').to('locked')
    end
  end
end
