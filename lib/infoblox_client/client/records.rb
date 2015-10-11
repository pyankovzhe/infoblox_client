module InfobloxClient
  class Client
    module Records

      def all_records_in_zone(zone)
        get("allrecords?_return_fields=zone,type,name,address&zone=#{zone}")
      end

      def get_record(ref)
          get(ref)
      end

      def add_record(attrs={})
        body = handle_record_attributes(attrs)
        body_json = JSON.dump(body)
        if !body_json.empty?
          post_request = -> { post("record:#{attrs['type'].downcase}", body_json) }
          handle_response(&post_request)
        else
          { 'error_message' => 'Incorrect type of record' }
        end
      end

      def delete_record(ref)
        delete(ref)
      end

      private

      def handle_record_attributes(attrs)
        type = attrs['type'].downcase if attrs['type']
        case type
        when 'a'
          { name: attrs['domain'], ipv4addr: attrs['address'] }
        when 'aaaa'
          { name: attrs['domain'], ipv6addr: attrs['address'] }
        when 'ptr'
          { ptrdname: attrs['domain'], ipv4addr: attrs['address'] }
        when 'cname'
          { canonical: attrs['domain'], name: attrs['alias'] }
        when 'txt'
          { name: attrs['domain'], text: attrs['text'] }
        when 'srv'
          { name: attrs['name'], port: attrs['port'], priority: attrs['priority'], target: attrs['target'], weight: attrs['weight'] }
        when 'mx'
          { name: attrs['domain'], mail_exchanger: attrs['mail_exchanger'], preference: attrs['preference'] }
        else
          {}
        end
      end
    end
  end
end
