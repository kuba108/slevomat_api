module SlevomatApi
  class Client

    attr_reader :partner_token, :api_secret, :api_url

    def initialize(partner_token, api_secret, api_url, version = 'v1', test_api = false)
      @partner_token = partner_token
      @api_secret = api_secret
      @api_url = api_url
      @version = version
      @test_api = test_api
    end

    def cancel_order(order_id, order_items, note = nil)
      endpoint_url = build_endpoint_url(order_id, 'cancel')
      body = {
        items: order_items,
        note: note
      }
      RequestMaker.new(self).send_post_request(endpoint_url, body)
    end

    def mark_pending(order_id)
      endpoint_url = build_endpoint_url(order_id, 'mark-pending')
      RequestMaker.new(self).send_post_request(endpoint_url)
    end

    def mark_en_route(order_id, auto_mark_delivered)
      endpoint_url = build_endpoint_url(order_id, 'mark-en-route')
      body = {
        autoMarkDelivered: auto_mark_delivered
      }
      RequestMaker.new(self).send_post_request(endpoint_url, body)
    end

    def mark_getting_ready_for_pickup(order_id, auto_mark_ready_for_pickup = false, auto_mark_delivered = false)
      endpoint_url = build_endpoint_url(order_id, 'mark-getting-ready-for-pickup')
      body = {
        autoMarkDelivered: auto_mark_delivered,
        autoMarkReadyForPickup: auto_mark_ready_for_pickup
      }
      RequestMaker.new(self).send_post_request(endpoint_url, body)
    end

    def mark_ready_for_pickup(order_id, auto_mark_delivered = false)
      endpoint_url = build_endpoint_url(order_id, 'mark-ready-for-pickup')
      body = {
        autoMarkDelivered: auto_mark_delivered
      }
      RequestMaker.new(self).send_post_request(endpoint_url, body)
    end

    def mark_delivered(order_id)
      endpoint_url = build_endpoint_url(order_id, 'mark-delivered')
      RequestMaker.new(self).send_post_request(endpoint_url)
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
      RequestMaker.new(self).send_post_request(endpoint_url, body)
    end

    private

    def api_version_url
      @test_api ? 'v1-test' : 'v1'
    end

    def build_endpoint_url(order_id, api_action)
      "#{@api_url}/#{api_version_url}/order/#{order_id}/#{api_action}"
    end

  end
end