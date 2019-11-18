require 'rails_helper'

RSpec.describe 'Fetch carriers by tracking position' do
  subject(:request) { get "/carriers/passed_by/#{latitude}/#{longitude}"}

  let(:body) { JSON.parse response.body }
  let(:code) { response.code }

  let(:latitude) { 0 }
  let(:longitude) { 0 }

  let(:carriers) { [carrier1, carrier2, carrier3] }

  let(:carrier1) do
    Carrier.create(locations: [Location.new(latitude: 5, longitude: 3), Location.new(latitude: 0, longitude: 0)])
  end

  let(:carrier2) do
    Carrier.create(locations: [Location.new(latitude: 2, longitude: 1)])
  end

  let(:carrier3) do
    Carrier.create(locations: [Location.new(latitude: 0, longitude: 0)])
  end

  before { carriers }

  it 'fetch by tracking' do
    request

    expect(code).to eq('200')
    expect(body.size).to eq(2)
  end
end
