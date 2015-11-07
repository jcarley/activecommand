require 'spec_helper'

RSpec.describe ActiveCommand::Command do

  it { is_expected.to respond_to(:run) }
  it { is_expected.to respond_to(:execute) }
  it { is_expected.to respond_to(:valid?) }
  it { is_expected.to respond_to(:to_params) }
  it { is_expected.to respond_to(:to_hash) }

  describe ".from_json" do
    subject { ActiveCommand::Command }

    it { is_expected.to respond_to(:from_json) }

    it "returns an instance of the command" do
      cmd = ActiveCommand::Command.from_json("{}")
      expect(cmd).to be_instance_of(ActiveCommand::Command)
    end

    it "populates attributes from the given json" do
      class NameCommand < ActiveCommand::Command
        attribute :name, String
      end

      json_attrs = JSON.dump({:name => "Jeff"})
      cmd = NameCommand.from_json(json_attrs)
      expect(cmd.name).to eql("Jeff")
    end

  end

  describe "#to_params" do

    class UserCommand < ActiveCommand::Command
      attribute :name, String
      attribute :age, Integer
    end

    it "serializes the command as a hash" do
      cmd = UserCommand.new(:name => "Jeff", :age => 38)
      attrs = cmd.to_params
      aggregate_failures "testing attrs" do
        expect(attrs[:name]).to eql("Jeff")
        expect(attrs[:age]).to eql(38)
      end
    end

    it "serializes with nil attributes removed" do
      cmd = UserCommand.new(:name => "Jeff")
      attrs = cmd.to_params
      aggregate_failures "testing attrs" do
        expect(attrs).to include(:name)
        expect(attrs).to_not include(:age)
      end
    end

    it "returns a hash with symbol and string key access" do
      cmd = UserCommand.new(:name => "Jeff")
      attrs = cmd.to_params
      aggregate_failures "testing attrs" do
        expect(attrs[:name]).to eql("Jeff")
        expect(attrs['name']).to eql("Jeff")
      end
    end

  end

  describe "#run" do

    it "checks if the command is valid" do
      cmd = ActiveCommand::Command.new
      allow(cmd).to receive(:valid?).and_return(true)
      allow(cmd).to receive(:execute)
      cmd.run
      expect(cmd).to have_received(:valid?)
    end

    it "calls execute when the command is valid" do
      cmd = ActiveCommand::Command.new
      allow(cmd).to receive(:execute)
      cmd.run
      expect(cmd).to have_received(:execute)
    end

    it "does not call execute when invalid" do
      cmd = ActiveCommand::Command.new
      allow(cmd).to receive(:execute)
      allow(cmd).to receive(:valid?).and_return(false)
      aggregate_failures "tesing run" do
        expect { cmd.run }.to raise_error(ActiveCommand::CommandNotValidError)
        expect(cmd).to_not have_received(:execute)
      end
    end

  end

  describe "#execute" do

    it "throws NotImplemented when not overridden" do
      cmd = ActiveCommand::Command.new
      expect { cmd.execute }.to raise_error(NotImplementedError)
    end

  end

end

