# frozen_string_literal: true

require "sidekiq_rescue"
Dir[File.join(__dir__, "support/**/*.rb")].sort.each { |f| require f }

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  if ENV["LOG"].nil?
    if defined?(Sidekiq::MAJOR) && Sidekiq::MAJOR >= 7
      Sidekiq.default_configuration.logger = nil
    else
      Sidekiq.logger = nil
    end
  end
end
