module SlevomatApi
  class Client

    attr_reader :partner_token, :api_secret, :api_url

    def initialize(partner_token, api_secret, api_url, version = 'v1', test_api = false)
      @partner_token = partner_token
      @api_secret = api_secret
      @api_url = api_url
      @version = version
      @test_api = test_api
      @response_validator = ResponseValidator.new
    end

    def cancel_order(order_id, order_items, note = nil)
      endpoint_url = build_endpoint_url(order_id, 'cancel')
      body = {
        items: order_items,
        note: note
      }
      response = RequestMaker.new(self).send_post_request(endpoint_url, body)
      @response_validator.validate_response(response)
    end

    def mark_pending(order_id)
      endpoint_url = build_endpoint_url(order_id, 'mark-pending')
      response = RequestMaker.new(self).send_post_request(endpoint_url)
      @response_validator.validate_response(response)
    end

    def mark_en_route(order_id, auto_mark_delivered)
      endpoint_url = build_endpoint_url(order_id, 'mark-en-route')
      body = {
        autoMarkDelivered: auto_mark_delivered
      }
      response = RequestMaker.new(self).send_post_request(endpoint_url, body)
      @response_validator.validate_response(response)
    end

    def mark_getting_ready_for_pickup(order_id, auto_mark_ready_for_pickup = false, auto_mark_delivered = false)
      endpoint_url = build_endpoint_url(order_id, 'mark-getting-ready-for-pickup')
      body = {
        autoMarkDelivered: auto_mark_delivered,
        autoMarkReadyForPickup: auto_mark_ready_for_pickup
      }
      response = RequestMaker.new(self).send_post_request(endpoint_url, body)
      @response_validator.validate_response(response)
    end

    def mark_ready_for_pickup(order_id, auto_mark_delivered = false)
      endpoint_url = build_endpoint_url(order_id, 'mark-ready-for-pickup')
      body = {
        autoMarkDelivered: auto_mark_delivered
      }
      response = RequestMaker.new(self).send_post_request(endpoint_url, body)
      @response_validator.validate_response(response)
    end

    def mark_delivered(order_id)
      endpoint_url = build_endpoint_url(order_id, 'mark-delivered')
      response = RequestMaker.new(self).send_post_request(endpoint_url)
      @response_validator.validate_response(response)
    end

    def update_shipping_address(order_id, name, street, city, state, phone, postal_code, company = nil)
      body = {
        name: name,
        street: street,
        city: city,
        state: state,
        phone: phone,
        postalCode: postal_code,
        company: company
      }

      endpoint_url = build_endpoint_url(order_id, 'update-shipping-address')
      response = RequestMaker.new(self).send_post_request(endpoint_url, body)
      @response_validator.validate_response(response)
    end

    private

    def api_version_url
      @test_api ? 'v1-test' : 'v1'
    end

    def build_endpoint_url(order_id, api_action)
      "#{@api_url}/#{api_version_url}/#{order_id}/#{api_action}"
    end

    # def initialize(attributes)
    #   attributes.each do |attr_name, attr_value|
    #     instance_variable_set "@#{attr_name}", attr_value
    #   end
    # end

  end
end