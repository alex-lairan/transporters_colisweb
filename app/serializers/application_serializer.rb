class ApplicationSerializer
  def call(element)
    case element
    when Array
      element.map { |item| call(item) }
    else
      serialize_element(element)
    end
  end
end