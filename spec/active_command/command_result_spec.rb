require 'spec_helper'

RSpec.describe ActiveCommand::CommandResult do

  let(:command) { double('command') }

  describe "success?" do

    it "returns true when no error" do
      cr = ActiveCommand::CommandResult.new(command)
      expect(cr).to be_success
    end

    it "returns false when there is an error" do
      cr = ActiveCommand::CommandResult.new(command)
      cr.error = StandardError.new
      expect(cr).to_not be_success
    end

  end

  describe "on_success?" do

    it "yields when successful" do
      cr = ActiveCommand::CommandResult.new(command)
      expect { |b| cr.on_success?(&b) }.to yield_control
    end

    it "does not yield when not successful" do
      cr = ActiveCommand::CommandResult.new(command)
      cr.error = StandardError.new
      expect { |b| cr.on_success?(&b) }.to_not yield_control
    end

  end

  describe "on_error?" do

    it "yields when there is an error" do
      cr = ActiveCommand::CommandResult.new(command)
      cr.error = StandardError.new
      expect { |b| cr.on_error?(&b) }.to yield_control
    end

    it "does not yield when successful" do
      cr = ActiveCommand::CommandResult.new(command)
      expect { |b| cr.on_error?(&b) }.to_not yield_control
    end

  end

end
