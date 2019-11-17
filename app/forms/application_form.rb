class ApplicationForm
  def initialize(validator:)
    @validator = validator
  end

  def call(params)
    @validator.call(params)
        .to_monad
        .or { |schema| return Dry::Monads::Failure(schema_error_mapper(schema.errors)) }
        .bind { |schema| on_success(schema) }
  end

  private

  def schema_error_mapper(errors)
    errors.map { |error| ValidationError.new(error.path, error.text) }
  end
end
