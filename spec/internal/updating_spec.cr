require "../spec_helper"

module SemverInternalUpdatingFeature
  describe name do
    it "major" do
      ver = Semver.parse("1.1.1-rc.1+build-794")
      ver.major!
      ver.to_s.should eq "2.0.0"
    end

    it "minor" do
      ver = Semver.parse("1.1.1-rc.1+build-794")
      ver.minor!
      ver.to_s.should eq "1.2.0"
    end

    it "patch" do
      ver = Semver.parse("1.1.1-rc.1+build-794")
      ver.patch!
      ver.to_s.should eq "1.1.2"
    end
  end
end
