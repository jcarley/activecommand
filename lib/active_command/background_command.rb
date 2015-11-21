module ActiveCommand
  module BackgroundCommand
    extend ActiveSupport::Concern

    included do
      attribute :job_id, String
    end

    module ClassMethods
    end

    def run
      if self.valid?
        data = {:wrapped_class => self.class.to_s, :arguments => self.to_params.to_json}
        BackgroundCommandJobWrapper.perform_later data.to_json
      else
        raise CommandNotValidError, self.errors.full_messages
      end
    end

    def perform(params)
      self.from_json(params)
      self.execute
    end

    class BackgroundCommandJobWrapper < ActiveJob::Base

      def perform(job_data)
        puts "Run from BackgroundCommand"
        data = JSON.parse(job_data, :symbolize_names => true)
        wrapped_class = data.fetch(:wrapped_class)
        arguments = data.fetch(:arguments, "{}")
        command = wrapped_class.constantize.new
        command.perform(arguments)
      end
    end

  end
end
