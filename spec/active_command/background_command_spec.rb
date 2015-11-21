require 'spec_helper'

module BackgroundCommandSpec
  class NoopCommand < ActiveCommand::Command

    set_as_background true

    attribute :id, String

    def execute
      puts "FUCK, it worked!!!!"
      puts "Id: #{id}"
    end

  end
end

RSpec.describe ActiveCommand::BackgroundCommand do

  it "does something" do
    cmd = BackgroundCommandSpec::NoopCommand.new(:id => "ABC123")
    ActiveCommand::CommandBus.execute(cmd)
  end

end

