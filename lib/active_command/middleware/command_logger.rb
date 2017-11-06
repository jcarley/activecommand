module ActiveCommand
  class CommandLogger

    def initialize(app)
      @app = app
    end

    def call(env)
      puts "--> Before"
      @app.call(env) if @app
      puts "--> After"
    end

  end
end
