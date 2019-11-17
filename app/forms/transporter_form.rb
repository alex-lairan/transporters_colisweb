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

class TransporterForm
  SIRET_ERROR = ValidationError.new(['SIRET'], 'must be uniq').freeze

  def initialize(validator:, klass: Transporter)
    @validator = validator
    @klass = klass
  end

  def call(params)
    @validator.call(params)
              .to_monad
              .or { |schema| return Dry::Monads::Failure(schema_error_mapper(schema.errors)) }
              .bind { |transporter_schema| on_success(transporter_schema) }
  end

  private

  def on_success(schema)
    return Dry::Monads::Failure([SIRET_ERROR]) if siret_exists?(schema[:SIRET])
    transporter = Transporter.new extract_transporter(schema)

    return Dry::Monads::Failure(transporter.errors) unless transporter.save

    import_postal_codes(schema[:postal_codes], transporter.id)
    import_carriers(schema[:carriers], transporter.id)

    Dry::Monads::Success(transporter)
  end

  def siret_exists?(siret)
    @klass.where(siret: siret).exists?
  end

  def extract_transporter(schema)
    {
        name: schema[:name],
        siret: schema[:SIRET]
    }
  end

  def build_postal_codes(codes)
    codes.map { |code| PostalCode.new(code: code) }
  end

  def import_postal_codes(code_array, transporter_id)
    PostalCode.import build_postal_codes(code_array), on_duplicate_key_ignore: true
    codes = PostalCode.where(code: code_array)
    transporter_codes = codes.map do |code|
      TransporterPostalCode.new postal_code_id: code.id, transporter_id: transporter_id
    end

    TransporterPostalCode.import transporter_codes, on_duplicate_key_ignore: true
  end

  def import_carriers(carrier_schema, transporter_id)
    carriers = carrier_schema.map do |carrier|
      Carrier.new transporter_id: transporter_id, **carrier
    end

    Carrier.import carriers
  end

  def schema_error_mapper(errors)
    errors.map { |error| ValidationError.new(error.path, error.text) }
  end
end
