require 'rails_helper'

RSpec.describe 'Create a transporter', type: :request do
  subject(:request) { post '/transporters', params }

  let(:body) { JSON.parse response.body }
  let(:code) { response.code }

  let(:params) do
    {
        name: 'Transporter name',
        SIRET: siret,
        postal_codes: %w(77178 94210),
        carriers: carriers
    }
  end

  let(:siret) { '732 829 320 00074' }

  context 'with correct values' do
    let(:carriers) do
      [
          {
              name: 'Alexandre Lairan',
              age: 22,
              has_driver_licence_a: false,
              has_driver_licence_b: true,
              has_driver_licence_c: false
          }
      ]
    end


    it do
      request

      expect(code).to eq('201')
      expect(body).to include('siret' => siret)
    end
  end

  context 'without any carriers' do
    let(:carriers) { [] }

    it do
      request

      expect(code).to eq('400')
      expect(body).to include('errors' => [{'path' => ['carriers'], 'text' => 'is missing'}])
    end
  end

  context 'with an existing transporter' do
    let(:carriers) do
      [
          {
              name: 'Alexandre Lairan',
              age: 22,
              has_driver_licence_a: false,
              has_driver_licence_b: true,
              has_driver_licence_c: false
          }
      ]
    end

    it do
      Transporter.create(siret: siret)

      request

      expect(code).to eq('400')
      expect(body).to include('errors' => [{'path' => ['SIRET'], 'text' => 'must be uniq'}])
    end
  end

  context 'with an underage carrier' do
    let(:error) { [{'path' =>['carriers', 0, 'age'], 'text' => 'must be greater than or equal to 18'}] }

    let(:carriers) do
      [
          {
              name: 'John Doe',
              age: 16,
              has_driver_licence_a: true,
              has_driver_licence_b: false,
              has_driver_licence_c: false
          }
      ]
    end

    it do
      request

      expect(code).to eq('400')
      expect(body).to include('errors' => error)
    end
  end

  context 'with a non driver carrier' do
    let(:error) { [{'path' =>['carriers', 0], 'text' => 'must have a driver licence'}] }

    let(:carriers) do
      [
          {
              name: 'Alexandre Lairan',
              age: 18,
              has_driver_licence_a: false,
              has_driver_licence_b: false,
              has_driver_licence_c: false
          }
      ]
    end


    it do
      request

      expect(code).to eq('400')
      expect(body).to include('errors' => error)
    end
  end

  context 'without mandatory field' do
    let(:errors) { [{'path' => ['SIRET'], 'text' => 'is missing'}, {'path' => ['carriers'], 'text' => 'is missing'}] }

    let(:params) do
      {
          name: 'Transporter name',
          postal_codes: %w(77178 94210),
      }
    end

    it do
      request

      expect(code).to eq('400')
      expect(body).to include('errors' => errors)
    end
  end
end
