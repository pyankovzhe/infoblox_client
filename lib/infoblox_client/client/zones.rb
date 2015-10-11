module InfobloxClient
  class Client
    module Zones

      def all_zones
        get('zone_auth')
      end

      def get_zone(ref)
        get(ref)
      end

      def delete_zone(ref)
        delete(ref)
      end

      #attrs = ({'fqdn' => 'o7.com'})
      def create_zone(attrs={})
        body = attrs.merge({'view' => 'default', 'ns_group' => 'NSGroup'})
        body_json = JSON.dump(body)
        post_request = -> { post('zone_auth', body_json) }
        handle_response(&post_request)
      end

      #'o7.com'
      def zone_exist?(name)
        response = get("zone_auth?fqdn=#{name}")
        !response.empty?
      end
    end
  end
end
