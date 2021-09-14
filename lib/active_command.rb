require 'virtus'
require 'middleware'
require 'active_support'
require 'active_support/hash_with_indifferent_access'
require 'active_model'
require 'sidekiq'

module ActiveCommand
  extend ActiveSupport::Autoload

  autoload :Core
  autoload :Command
  autoload :BackgroundCommand
  autoload :CommandBus
  autoload :CommandResult
  autoload :CommandNotValidError

  autoload_under 'middleware' do
    autoload :CommandRunner
  end

  def self.execute_now(command)
    CommandBus.execute_now(command)
  end

end

