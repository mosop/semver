require "../spec_helper"

module SemverInternalUpdatingFeature
  it "works" do
    ver = Semver.parse("1.0.0-rc.1+build-794")
    ver.short_string.should eq "1.0-rc.1+build-794"
  end
end
