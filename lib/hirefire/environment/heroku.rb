# encoding: utf-8

require 'heroku-api'

module HireFire
  module Environment
    class Heroku < Base

      private

      ##
      # Either retrieves the amount of currently running workers,
      # or set the amount of workers to a specific amount by providing a value
      #
      # @overload workers(amount = nil)
      #   @param [Fixnum] amount will tell heroku to run N workers
      #   @return [nil]
      # @overload workers(amount = nil)
      #   @param [nil] amount
      #   @return [Fixnum] will request the amount of currently running workers from Heroku
      def workers(amount = nil)
        if amount.nil?
          client.get_ps(ENV['APP_NAME']).body.select { |ps| ps['process'] =~ /worker/ }.length
        else
          client.post_ps_scale(ENV['APP_NAME'], 'worker', amount)
        end
      rescue RestClient::Exception
        # Heroku library uses rest-client, currently, and it is quite
        # possible to receive RestClient exceptions through the client.
        HireFire::Logger.instance.info("Worker query request failed with #{ $!.class.name } #{ $!.message }")
        nil
      end

      ##
      # @return [Heroku::API] instance of the heroku client
      def client
        @client ||= ::Heroku::API.new(
          :username => ENV['HIREFIRE_EMAIL'],
          :password => ENV['HIREFIRE_PASSWORD']
        )
      end

    end
  end
end
