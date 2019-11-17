require 'rails_helper'

RSpec.describe 'Fetch transporters by postal codes', type: :request do
  subject(:request) { get '/transporters/by_postal_codes' }

  let(:body) { JSON.parse response.body }
  let(:code) { response.code }

  let(:transporter) do
    Transporter.create name: 'Transporter name', siret: '732 829 320 00074',
                       postal_codes: postal_codes, carriers: carriers
  end

  let(:postal_codes) do
    [
      PostalCode.new(code: '75002'),
      PostalCode.new(code: '75006'),
    ]
  end

  let(:carriers) do
    [
      Carrier.new(name: 'John Doe', age: 32, has_driver_licence_a: true,
                  has_driver_licence_b: false, has_driver_licence_c: false)
    ]
  end

  before { transporter }

  it 'fetch by postal codes' do
    request

    expect(code).to eq('200')
    expect(body.size).to eq(2)
    expect(body[0]['postal_code']).to eq('75002')
    expect(body[1]['postal_code']).to eq('75006')
  end
end
