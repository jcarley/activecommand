require 'spec_helper'

module CommandBusSpec
  class NoopCommand < ActiveCommand::Command
    def execute; end
  end
end

RSpec.describe ActiveCommand::CommandBus do

  let(:noop_command) do
    CommandBusSpec::NoopCommand.new.tap do |c|
      allow(c).to receive(:execute)
    end
  end

  describe "instance" do

    it "returns the same instance of CommandBus" do
      bus1 = ActiveCommand::CommandBus.instance
      bus2 = ActiveCommand::CommandBus.instance
      expect(bus1).to equal(bus2)
    end

  end

  describe ".execute" do

    it "executes a command" do
      ActiveCommand::CommandBus.execute(noop_command)
      expect(noop_command).to have_received(:execute)
    end

    it "returns a command result" do
      cmd_result = ActiveCommand::CommandBus.execute(noop_command)
      expect(cmd_result).to be_instance_of(ActiveCommand::CommandResult)
    end

  end

  describe "#execute" do

    it "executes a command" do
      cmd_bus = ActiveCommand::CommandBus.instance
      cmd_bus.execute(noop_command)
      expect(noop_command).to have_received(:execute)
    end

    it "returns a command result" do
      cmd_bus = ActiveCommand::CommandBus.instance
      cmd_result = cmd_bus.execute(noop_command)
      expect(cmd_result).to be_instance_of(ActiveCommand::CommandResult)
    end

  end

end

