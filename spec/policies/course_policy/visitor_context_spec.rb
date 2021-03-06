# frozen_string_literal: true

require "rails_helper"

describe CoursePolicy do
  subject { described_class.new(visitor, course) }

  let(:visitor) { nil }

  context "visitor accessing a course" do
    let(:course) { create(:course) }

    it { is_expected.to forbid_actions(%i[show create update destroy]) }
  end
end
