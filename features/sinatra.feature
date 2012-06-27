Feature: Use the notifier in a Sinatra app

  Background:
    Given I have built and installed the "honeybadger" gem

  Scenario: Rescue an exception in a Sinatra app
    Given the following Rack app:
      """
      require 'sinatra/base'
      require 'honeybadger'

      Honeybadger.configure do |config|
        config.api_key = 'my_api_key'
      end

      class FontaneApp < Sinatra::Base
        use Honeybadger::Rack
        enable :raise_errors

        get "/test/index" do
          raise "Sinatra has left the building"
        end
      end

      app = FontaneApp
      """
    When I perform a Rack request to "http://example.com:123/test/index?param=value"
    Then I should receive a Honeybadger notification

