require 'helper'

describe Ikachan::Client do
  let :client do
    described_class.new(params)
  end

  describe '.new' do
    context 'When only hostname is given' do
      let :params do
        {:hostname => 'irc.example.com'}
      end

      it do
        expect(client.hostname).to eq('irc.example.com')
        expect(client.port).to     eq(6667)
        expect(client.ssl).to      eq(false)
      end
    end

    context 'When hostname, port and ssl are given' do
      let :params do
        {:hostname => 'irc.example.com', :port => 6668, :ssl => true}
      end

      it do
        expect(client.hostname).to eq('irc.example.com')
        expect(client.port).to     eq(6668)
        expect(client.ssl).to      eq(true)
      end
    end
  end

  describe '#to' do
    let :params do
      {:hostname => 'irc.example.com'}
    end

    before do
      @result = client.to('#ruby')
    end

    it do
      expect(@result).to eq(client)
    end

    it do
      expect(client.channel).to eq('#ruby')
    end
  end

  describe '#notify' do
    let :params do
      {:hostname => 'irc.example.com', :ssl => true}
    end

    let :message do
      'No Ruby No Life.'
    end

    before do
      # join
      stub_request(:post, 'https://irc.example.com:6667/join')
        .with(:body => {'channel'=>'#ruby'})
        .to_return(:status => 200, :body => '')

      # notice
      stub_request(:post, 'https://irc.example.com:6667/notice')
        .with(:body => {'channel'=>'#ruby', 'message' => message})
        .to_return(:status => 200, :body => '')
    end

    it do
      expect {
        client.to('#ruby').notify(message)
      }.to_not raise_error(Exception)
    end
  end
end
