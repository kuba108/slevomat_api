module SlevomatApi
  class Client

    attr_reader :partner_token, :api_secret, :api_url

    def initialize(partner_token, api_secret, api_url)
      @partner_token = partner_token
      @api_secret = api_secret
      @api_url = api_url
    end

    # def initialize(attributes)
    #   attributes.each do |attr_name, attr_value|
    #     instance_variable_set "@#{attr_name}", attr_value
    #   end
    # end

  end
end