require "../spec_helper"

module SemverComponentsFeature
  it name do
    ver = Semver.parse("1.0.0-rc.1+build-794")
    ver.major.should eq 1
    ver.minor.should eq 0
    ver.patch.should eq 0
    ver.prerelease.should eq "rc.1"
    ver.build.should eq "build-794"
    ver.prerelease_components.should eq ["rc", 1] of String | Int32
  end
end
