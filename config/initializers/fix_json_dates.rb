# Without this, dates returned by AJAX are in the wrong format, something like
# "2012-11-12T10:00:08", which is close, but no cookie.
#
# Solution per http://stackoverflow.com/questions/2937740/rails-dates-with-json

class ActiveSupport::TimeWithZone
  def as_json(options={})
    strftime("%Y-%m-%d %H:%M:%S %Z")
  end
end
