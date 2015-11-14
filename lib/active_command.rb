require 'virtus'
require 'middleware'
require 'active_support'
require 'active_support/hash_with_indifferent_access'
require 'active_model'

module ActiveCommand
  extend ActiveSupport::Autoload

  autoload :Command
  autoload :CommandBus
  autoload :CommandResult
  autoload :CommandNotValidError

  autoload_under 'middleware' do
    autoload :CommandRunner
  end

end

