require 'spec_helper'

RSpec.describe ActiveCommand do

  it 'has a version number' do
    expect(ActiveCommand::VERSION).not_to be nil
  end

  describe '.execute_now' do

    class UserCommand < ActiveCommand::Command
      attribute :name, String
      attribute :age, Integer
    end

    let(:user_command) do
      UserCommand.new.tap do |c|
        allow(c).to receive(:execute)
      end
    end

    it "executes the command with the command bus" do
      ActiveCommand.execute_now(user_command)
      expect(user_command).to have_received(:execute)
    end
  end

end
