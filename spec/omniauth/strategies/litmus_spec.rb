require 'spec_helper'

describe OmniAuth::Strategies::Litmus do
  let(:access_token) { instance_double('AccessToken', :options => {}) }

  subject do
    OmniAuth::Strategies::Litmus.new({})
  end

  before(:each) do
    allow(subject).to receive(:access_token).and_return(access_token)
  end

  context 'client options' do
    it 'should have correct site' do
      expect(subject.options.client_options.site).to eq('https://litmus.com')
    end
  end

  describe '#raw_info' do
    let(:user_hash) { double('User')}
    let(:parsed_response) { instance_double('ParsedResponse', :[] => user_hash) }
    let(:response) { instance_double('Response', parsed: parsed_response) }

    it 'should use litmus personal API endpoint' do
      expect(access_token).to receive(:get).with('https://api.litmus.com/v2/users/current').and_return(response)
      expect(subject.raw_info).to eq(user_hash)
    end
  end

  describe '#info' do
    before do
      allow(subject).to receive(:raw_info).and_return({
        "full_name" => "Mary Poppins",
        "first_name" => "Mary",
        "last_name" => "Poppins"
      })
    end
    it 'exposes name' do
      expect(subject.info['name']).to eq('Mary Poppins')
    end
    it 'exposes first_name' do
      expect(subject.info['first_name']).to eq('Mary')
    end
    it 'exposes last_name' do
      expect(subject.info['last_name']).to eq('Poppins')
    end
  end

  describe '#callback_url' do
    it 'is a combination of host and callback path (excludes query params)' do
      allow(subject).to receive(:full_host).and_return('https://example.com')
      allow(subject).to receive(:callback_path).and_return('/auth/litmus/callback')
      allow(subject).to receive(:query_string).and_return('?foo=bar')
      expect(subject.callback_url).to eq('https://example.com/auth/litmus/callback')
    end
  end
end
