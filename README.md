# Semver

Yet another Crystal library for Semantic Versioning. Its implementation is slightly different than the Crystal standard library.

[![Build Status](https://travis-ci.org/mosop/semver.svg?branch=master)](https://travis-ci.org/mosop/semver)

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  semver:
    github: mosop/semver
```

## Usage

```crystal
require "semver"
```

## Components

```crystal
ver = Semver.parse("1.0.0-rc.1+build-794")
ver.major      # 1
ver.minor      # 0
ver.patch      # 0
ver.prerelease # "rc.1"
ver.build      # "build-794"
```

## Comparison

Semver implements:

  * Comparable(Semver)
  * Comparable(String)

```crystal
Semver.parse("1.0.0-alpha") < "1.0.0-beta" # true
```

## Contributing

1. Fork it ( https://github.com/mosop/semver/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [mosop](https://github.com/mosop) - creator, maintainer
