require 'uri'

module Phase5
  class Params
    # use your initialize to merge params from
    # 1. query string
    # 2. post body
    # 3. route params
    #
    # You haven't done routing yet; but assume route params will be
    # passed in as a hash to `Params.new` as below:
    def initialize(req, route_params = {})
      input_params = req.query_string.to_s + req.body.to_s
      @params = parse_www_encoded_form(input_params, route_params)
    end

    def [](key)
      @params[key.to_s]
    end

    def to_s
      @params.to_json.to_s
    end

    class AttributeNotFoundError < ArgumentError; end;

    # private
    # this should return deeply nested hash
    # argument format
    # user[address][street]=main&user[address][zip]=89436
    # should return
    # { "user" => { "address" => { "street" => "main", "zip" => "89436" } } }
    def parse_www_encoded_form(www_encoded_form, route_params = {})
      return route_params if www_encoded_form.nil?
      arr = URI::decode_www_form(www_encoded_form)
      result = route_params

      arr.map! { |(key, value)| parse_key(key) + [value] }

      arr.each do |sub_arr|
        current_hash = result

        (sub_arr.length - 2).times do |i|
          current_key = sub_arr[i]

          unless current_hash.keys.include?(current_key)
            current_hash[current_key] = {}
          end

          current_hash = current_hash[current_key]
        end

        last_key = sub_arr[-2]
        value = sub_arr[-1]
        current_hash[last_key] = value
      end

      result
    end

    # this should return an array
    # user[address][street] should return ['user', 'address', 'street']
    def parse_key(key)
      key.split(/\]\[|\[|\]/)
    end
  end
end
