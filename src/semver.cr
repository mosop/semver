require "./*"

struct Semver
  include Comparable(self)
  include Comparable(String)

  getter major : Int32
  getter minor : Int32
  getter patch : Int32
  getter prerelease : String?
  getter build : String?

  def initialize(@major, @minor, @patch, @prerelease, @build, @string = nil)
  end

  def self.parse(string)
    raise ArgumentError.new("Wrong semver syntax: #{string}") unless string =~ /^(\d+)(?:\.(\d+)(?:\.(\d+)(?:-([0-9A-Za-z-]+(?:\.[0-9A-Za-z-]+)*))?(?:\+([0-9A-Za-z.-]+))?)?)?$/
    new($1.to_i, $2?.try(&.to_i) || 0, $3?.try(&.to_i) || 0, $4?, $5?, string)
  end

  @string : String?
  def string
    @string ||= begin
      s = [major, minor, patch].join(".")
      s += "-#{prerelease}" if prerelease
      s += "+#{build}" if build
      s
    end
  end

  @short_string : String?
  def short_string
    @short_string ||= begin
      a = [major, minor]
      a << patch if patch > 0
      s = a.join(".")
      s += "-#{prerelease}" if prerelease
      s += "+#{build}" if build
      s
    end
  end

  def major=(v)
    @string = nil
    @short_string = nil
    @major = v
  end

  def minor=(v)
    @string = nil
    @short_string = nil
    @minor = v
  end

  def patch=(v)
    @string = nil
    @short_string = nil
    @patch = v
  end

  def prerelease=(v)
    @string = nil
    @short_string = nil
    @prerelease = v
  end

  def build=(v)
    @string = nil
    @short_string = nil
    @build = v
  end

  @prerelease_components : Array(String | Int32)?
  def prerelease_components
    @prerelease_components ||= prerelease ? prerelease.to_s.split(".").map{|i| i =~ /^\d+$/ ? i.to_i : i} : [] of String | Int32
  end

  def to_s(io : IO)
    io << string
  end

  def <=>(other : Semver)
    compare(major, other.major) do
      compare(minor, other.minor) do
        compare(patch, other.patch) do
          if prerelease_components.size == 0
            return 1 if other.prerelease_components.size > 0
          else
            return -1 if other.prerelease_components.size == 0
          end
          compare(prerelease_components, other.prerelease_components)
        end
      end
    end
  end

  def <=>(s : String)
    self <=> Semver.parse(s)
  end

  private def compare(a : Int32, b : Int32)
    n = a <=> b
    n == 0 ? yield : n
  end

  private def compare(a : String | Int32, b : String | Int32)
    if sa = a.as?(String)
      if sb = b.as?(String)
        n = sa <=> sb
        n == 0 ? yield : n
      else
        1
      end
    else
      if ib = b.as?(Int32)
        n = a.as(Int32) <=> ib
        n == 0 ? yield : n
      else
        -1
      end
    end
  end

  private def compare(a : Array(String | Int32), b : Array(String | Int32))
    return b.size == 0 ? 0 : -1 if a.size == 0
    return 1 if b.size == 0
    compare(a[0], b[0]) do
      compare(a[1..-1], b[1..-1])
    end
  end

  def major!
    self.major = major + 1
    self.minor = 0
    self.patch = 0
    self.prerelease = nil
    self.build = nil
  end

  def minor!
    self.minor = minor + 1
    self.patch = 0
    self.prerelease = nil
    self.build = nil
  end

  def patch!
    self.patch = patch + 1
    self.prerelease = nil
    self.build = nil
  end
end
