require 'spec_helper'

RSpec.describe ActiveCommand::CommandLogger do

  let(:next_middleware) { double('next_middleware', :call => nil) }

  subject { ActiveCommand::CommandLogger.new(next_middleware) }

  describe "#call" do

    it "" do

    end

    it "calls the next middleware component" do
      command = double("command", :run => nil)
      env = {:command => command}
      subject.call(env)
      expect(next_middleware).to have_received(:call)
    end

  end

end
