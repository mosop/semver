require "../spec_helper"

module SemverInternalShortStringFeature
  it "omits patch version" do
    ver = Semver.parse("1.0.0-rc.1+build-794")
    ver.short_string.should eq "1.0-rc.1+build-794"
  end

  it "does not omit patch version if major version is 0" do
    ver = Semver.parse("0.1-rc.1+build-794", omittable: true)
    ver.short_string.should eq "0.1.0-rc.1+build-794"
  end
end
