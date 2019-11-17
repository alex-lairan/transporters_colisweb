class ValidationError
  def initialize(path, text)
    @path = path
    @text = text
  end

  def as_json(*)
    {
        path: @path,
        text: @text
    }
  end
  alias_method :to_h, :as_json

  def to_json
    as_json.to_json
  end
end
