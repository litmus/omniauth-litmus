require "omniauth-oauth2"

module OmniAuth
  module Strategies
    class Litmus < OmniAuth::Strategies::OAuth2
      OAUTH_HOST = ENV["LITMUS_OAUTH_HOST"] || "https://litmus.com"
      API_HOST = ENV["LITMUS_API_HOST"] || "https://api.litmus.com"

      option :name, "litmus"
      option :client_options, {
        site: OAUTH_HOST
      }

      uid { raw_info["id"].to_s }
      info do
        {
          "name"       => raw_info["full_name"],
          "first_name" => raw_info["first_name"],
          "last_name"  => raw_info["last_name"]
        }
      end

      def raw_info
        access_token.options[:mode] = :query
        @raw_info ||= access_token.
                        get("#{API_HOST}/v2/users/current").
                        parsed["user"]
      end

      def callback_url
        full_host + callback_path
      end
    end
  end
end
