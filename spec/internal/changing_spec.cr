require "../spec_helper"

module SemverInternalChangingFeature
  it name do
    ver = Semver.parse("1.1.1-rc.1+build-794")
    ver.major = 2
    ver.minor = 2
    ver.patch = 2
    ver.prerelease = "rc.2"
    ver.build = "build-795"
    ver.to_s.should eq "2.2.2-rc.2+build-795"
  end
end
