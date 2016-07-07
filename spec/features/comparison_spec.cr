require "../spec_helper"

module SemverComparisonFeature
  LESSTHAN = %w(
    1.0.0-alpha
    1.0.0-alpha.1
    1.0.0-alpha.beta
    1.0.0-beta
    1.0.0-beta.2
    1.0.0-beta.11
    1.0.0-rc.1
    1.0.0
  )

  EQUAL = %w(
    1.0.0+001
    1.0.0+20130313144700
    1.0.0+exp.sha.5114f85
  )

  describe name do
    it "less than" do
      LESSTHAN.reduce do |a, b|
        (Semver.parse(a) < Semver.parse(b)).should be_true
        b
      end
    end

    it "less than string" do
      LESSTHAN.reduce do |a, b|
        (Semver.parse(a) < b).should be_true
        b
      end
    end

    it "equal" do
      EQUAL.reduce do |a, b|
        (Semver.parse(a) == Semver.parse(b)).should be_true
        b
      end
    end

    it "equal to string" do
      EQUAL.reduce do |a, b|
        (Semver.parse(a) == b).should be_true
        b
      end
    end
  end
end
