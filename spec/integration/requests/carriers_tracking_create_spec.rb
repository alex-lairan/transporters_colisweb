require 'rails_helper'

RSpec.describe 'List carrier of a transporter', type: :request do
  subject(:request) { put "/carrier/#{carrier_id}/trackings", params }

  let(:body) { JSON.parse response.body }
  let(:code) { response.code }

  let(:carrier) { Carrier.create }
  let(:carrier_id) { carrier.id }

  let(:params) do
    {
      latitude: 48.8566,
      longitude: 2.3522,
      altitude: 15.2
    }
  end

  it 'create a tracking linked to the carrier' do
    request

    expect(code).to eq('201')
    %i(altitude longitude altitude).each do |attribute|
      expect(body[attribute.to_s]).to eq(params[attribute])
    end
  end
end
