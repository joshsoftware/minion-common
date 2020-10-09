# The FileInfo structure has data that it doesn't expose in the public UI, but which is
# useful or necessary for some capabilities. This monkey patch exposes creation_time as
# a method, and also provides access to the raw structure. Eventually Crystal should provide
# built in access to this data, but this gets around that for now.

struct Crystal::System::FileInfo

  def creation_time : ::Time
    {% if flag?(:darwin) %}
      ::Time.new(@stat.st_ctimespec, ::Time::Location::UTC)
    {% else %}
      ::Time.new(@stat.st_ctim, ::Time::Location::UTC)
    {% end %}
  end

  def raw
    @stat
  end

end
