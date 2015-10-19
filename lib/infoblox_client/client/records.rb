module InfobloxClient
  class Client
    module Records

      def all_records_in_zone(zone)
        get("allrecords?_return_fields=zone,address&zone=#{zone}")
      end

      def record(ref)
        get(ref)
      end

      def create_record(attrs={})
        type = attrs.delete(:type)
        body = JSON.dump(attrs)
        if !body.empty?
          post_request = -> { post("record:#{type.downcase}", body) }
          handle_response(&post_request)
        else
          { 'error_message' => 'Incorrect type of record' }
        end
      end

      def delete_record(ref)
        delete(ref)
      end

      def soa_record(ref)
        get("#{ref}?_return_fields=#{soa_data}")
      end

      private

      def soa_data
        'soa_serial_number,soa_email,soa_expire,soa_retry,soa_refresh,soa_default_ttl,soa_negative_ttl'
      end
    end
  end
end
