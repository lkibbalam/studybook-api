# frozen_string_literal: true

# frozen_string_true: true

require "rails_helper"

describe UserPolicy do
  subject { described_class.new(student, user) }

  let(:resolved_scope) do
    described_class::Scope.new(student, User.all).resolve
  end

  context "active student accessing to actions" do
    let(:student) { create(:user) }
    let(:user) { create(:user) }

    it "excludes student accessing to actions" do
      expect(resolved_scope).not_to include(user)
    end

    context "own account" do
      let(:user) { student }

      it { is_expected.to permit_actions(%i[current show change_password]) }
      it { is_expected.to forbid_actions(%i[create destroy]) }
    end

    context "not own account" do
      let(:user) { create(:user) }

      it { is_expected.to forbid_actions(%i[show create update destroy change_password]) }
    end
  end

  context "inactive student accessing to actions" do
    let(:student) { create(:user, :inactive) }
    let(:user) { create(:user) }

    it "excluded user from resolved scope" do
      expect(resolved_scope).not_to include(user)
    end

    it { is_expected.to forbid_actions(%i[current show create update destroy change_password]) }
  end

  describe "permitted attributes for student own record" do
    let(:student) { create(:user) }
    let(:user) { student }

    it do
      is_expected
        .to permit_mass_assignment_of(%i[email first_name last_name
                                         nickname phone avatar github_url
                                         current_password new_password
                                         password_confirmation])
    end

    it do
      is_expected
        .to forbid_mass_assignment_of(%i[team_id mentor_id status role password])
    end
  end
end
