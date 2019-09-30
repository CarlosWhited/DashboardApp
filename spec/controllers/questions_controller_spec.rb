require 'rails_helper'

describe QuestionsController do
  describe '#index' do
    let(:tenant) { instance_double("Tenant", api_key: 'test') }

    context 'when api key is not present' do
      it 'renders with a 401 status code' do
        get :index
        expect(response.status).to eq(401)
      end
    end

    context 'when api key is not valid' do
      it 'renders with a 401 status code' do
        get :index, api_key: 'blah'
        expect(response.status).to eq(401)
      end
    end

    context 'when tenant exists and is not being throttled' do
      it 'renders with all questions' do
        allow(Tenant).to receive(:where) { [tenant] }
        allow(tenant).to receive(:should_throttle?) { false }
        allow(tenant).to receive(:log_request)
        get :index, api_key: 'blah'
        expect(response.status).to eq(200)
      end
    end

    context 'when tenant exists and is being throttled' do
      it 'renders with a 401 status code' do
        allow(Tenant).to receive(:where) { [tenant] }
        allow(tenant).to receive(:should_throttle?) { true }
        allow(tenant).to receive(:log_request)
        get :index, api_key: 'blah'
        expect(response.status).to eq(401)
      end
    end
  end
end
