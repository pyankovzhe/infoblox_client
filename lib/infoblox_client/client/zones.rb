module InfobloxClient
  class Client
    module Zones

      def zones
        get('zone_auth')
      end

      def zone(ref)
        get(ref)
      end

      def delete_zone(ref)
        delete(ref)
      end

      def create_zone(attrs={})
        body = attrs.merge({'view' => 'default'})
        body_json = JSON.dump(body)
        post_request = -> { post('zone_auth', body_json) }
        handle_response(&post_request)
      end

      def zone_exist?(name)
        response = get("zone_auth?fqdn=#{name}")
        !response.empty?
      end
    end
  end
end
