require 'rails_helper'

RSpec.describe 'List carrier of a transporter', type: :request do
  subject(:request) { get "/transporters/#{transporter_id}/carriers" }

  let(:body) { JSON.parse response.body }
  let(:code) { response.code }

  context 'with existing transporter' do
    let(:transporter) { Transporter.create }
    let(:transporter_id) { transporter.id }

    let(:carriers) do
      [
        carrier1,
        carrier2
      ]
    end

    let(:carrier1) do
      Carrier.create(transporter_id: transporter_id,
                     name: 'Alexandre Lairan',
                     age: 22,
                     has_driver_licence_a: false,
                     has_driver_licence_b: true,
                     has_driver_licence_c: false
      )
    end

    let(:carrier2) do
      Carrier.create(transporter_id: transporter_id,
                     name: 'John Doe',
                     age: 43,
                     has_driver_licence_a: false,
                     has_driver_licence_b: true,
                     has_driver_licence_c: true
      )
    end

    before { carriers }

    it do
      request

      expect(code).to eq('200')
      expect(body.size).to eq(2)
      expect(response.body).to eq(carriers.to_json)
    end
  end

  context 'with non-existing transporter' do
    let(:transporter_id) { '0' }

    it do
      request

      expect(code).to eq('200')
      expect(body.size).to eq(0)
      expect(response.body).to eq('[]')
    end
  end
end
