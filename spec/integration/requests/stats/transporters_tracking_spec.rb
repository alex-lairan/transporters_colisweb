require 'rails_helper'

RSpec.describe 'Fetch transporters by carrier tracking position' do
  subject(:request) { get "/transporters/with_carriers_passed_by/#{latitude}/#{longitude}"}

  let(:body) { JSON.parse response.body }
  let(:code) { response.code }

  let(:latitude) { 0 }
  let(:longitude) { 0 }

  let(:transporters) { [transporter1, transporter2] }

  let(:transporter1) { Transporter.create(carriers: [carrier1, carrier2]) }
  let(:transporter2) { Transporter.create(carriers: [carrier3]) }

  let(:carrier1) do
    Carrier.new(locations: [Location.new(latitude: 5, longitude: 3), Location.new(latitude: 0, longitude: 0)])
  end

  let(:carrier2) do
    Carrier.new(locations: [Location.new(latitude: 2, longitude: 1)])
  end

  let(:carrier3) do
    Carrier.new(locations: [Location.new(latitude: 0, longitude: 0)])
  end

  before { transporters }

  it 'fetch by tracking' do
    request

    expect(code).to eq('200')
    expect(body.size).to eq(2)
    expect(body[0]['carriers'].size).to eq(1)
    expect(body[1]['carriers'].size).to eq(1)
  end
end
