require 'spec_helper'

RSpec.describe ActiveCommand::CommandRunner do

  let(:next_middleware) { double('next_middleware', :call => nil) }

  subject { ActiveCommand::CommandRunner.new(next_middleware) }

  describe "#call" do

    it "raises an error when an invalid command is object given" do
      env = {}
      subject.call(env)
      cr = env.fetch(:command_result)

      aggregate_failures do
        expect(cr).to_not be_success
        expect(cr.error).to be_instance_of(ActiveCommand::CommandRunner::MissingCommandError)
      end

    end

    it "runs the command" do
      command = double("command", :run => nil)
      env = {:command => command}
      subject.call(env)
      cr = env.fetch(:command_result)
      expect(command).to have_received(:run)
    end

    it "when successful it returns a command result with no errors" do
      command = double("command", :run => nil)
      env = {:command => command}
      subject.call(env)
      cr = env.fetch(:command_result)
      expect(cr.error).to be_nil
    end

    it "when unsuccessful it returns a command result with an error" do
      command = double("command")
      allow(command).to receive(:run).and_raise(StandardError)
      env = {:command => command}
      subject.call(env)
      cr = env.fetch(:command_result)
      aggregate_failures do
        expect(cr.error).to_not be_nil
        expect(cr.error).to be_instance_of(StandardError)
      end
    end

    it "calls the next middleware component" do
      command = double("command", :run => nil)
      env = {:command => command}
      subject.call(env)
      expect(next_middleware).to have_received(:call)
    end

  end
end

