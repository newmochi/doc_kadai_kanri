# Set up gems listed in the Gemfile.
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' if File.exist?(ENV['BUNDLE_GEMFILE'])
#20140807 portを3001に
require 'rails/commands/server'
module Rails
  class Server
    def default_options
      super.merge({
        :Port => 3001
      })
    end
  end
end

