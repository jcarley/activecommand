require 'active_support'
require 'active_support/hash_with_indifferent_access'
require 'active_model'
require 'virtus'

module ActiveCommand
  extend ActiveSupport::Autoload

  autoload :Command
  autoload :CommandNotValidError

end

