require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Role inheritance" do
  CanCanSetup.setup do
    delegate_roles [:circle, :square], to: [:figure]
    delegate_roles :figure, to: :geometry
    delegate_roles [:geometry, :chemistry], to: :science
    delegate_roles [:propane], to: :chemistry
  end

  class Ability
    include CanCanSetup::Ability
  end

  class User
    def roles
      @roles ||= Set.new
    end
  end

  let(:user) { User.new }
  let(:ability) { Ability.new(user) }

  context "circle role" do
    before { user.roles << :circle }

    it { ability.has_any_role(:circle).should be_true }
    it { ability.has_any_role(:figure, :circle).should be_true }
    it { ability.has_any_role(:square, :geometry, :figure).should be_false }
  end

  context "figure role" do
    before { user.roles << :figure }

    it { ability.has_any_role(:circle).should be_true }
    it { ability.has_any_role(:figure, :geometry).should be_true }
    it { ability.has_any_role(:geometry, :science).should be_false }
  end

  context "geometry role" do
    before { user.roles << :geometry }

    it { ability.has_any_role(:geometry).should be_true }
    it { ability.has_any_role(:square).should be_true }
    it { ability.has_any_role(:figure).should be_true }
    it { ability.has_any_role(:science).should be_false }
  end

  context "science role" do
    before { user.roles << :science }

    it { ability.has_any_role(:science).should be_true }
    it { ability.has_any_role(:square).should be_true }
    it { ability.has_any_role(:figure).should be_true }
    it { ability.has_any_role(:geometry).should be_true }
    it { ability.has_any_role(:chemistry).should be_true }
  end

  context "chemistry and geometry roles" do
    before do
      user.roles << :chemistry
      user.roles << :geometry
    end

    it { ability.has_any_role(:science).should be_false }
    it { ability.has_any_role(:square).should be_true }
    it { ability.has_any_role(:figure).should be_true }
    it { ability.has_any_role(:geometry).should be_true }
    it { ability.has_any_role(:chemistry).should be_true }
    it { ability.has_any_role(:propane).should be_true }
  end
end