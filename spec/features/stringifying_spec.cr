require "../spec_helper"

module SemverStringifyingFeature
  STRING = "1.0.0-rc.1+build-794"

  it name do
    ver = Semver.parse(STRING)
    ver.string.should eq STRING
    ver.to_s.should eq STRING
  end
end
