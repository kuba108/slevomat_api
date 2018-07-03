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

    # Sends cancel order request to Slevomat.
    #
    # Params:
    #   order_id: (String) order SlevomatID
    #   items: (Array) example: [{ 'slevomatId': '45454', 'amount': 1 }]
    #   note: (String) note with reason to cancel order
    def cancel_order(order_id, order_items, note = nil)
      endpoint_url = build_endpoint_url(order_id, 'cancel')
      body = {
        items: order_items,
        note: note
      }
      RequestMaker.new(@partner_token, @api_secret).send_post_request(endpoint_url, body)
    end

    # Marks order as pending.
    #
    # Params:
    #   order_id: (String) order SlevomatID
    def mark_pending(order_id)
      endpoint_url = build_endpoint_url(order_id, 'mark-pending')
      RequestMaker.new(@partner_token, @api_secret).send_post_request(endpoint_url)
    end

    # Marks order as order on the road.
    #
    # Params:
    #   order_id: (String) order SlevomatID
    #   auto_mark_delivered: (Boolean) auto mark order as delivered
    def mark_en_route(order_id, auto_mark_delivered = false)
      endpoint_url = build_endpoint_url(order_id, 'mark-en-route')
      body = {
        autoMarkDelivered: auto_mark_delivered
      }
      RequestMaker.new(@partner_token, @api_secret).send_post_request(endpoint_url, body)
    end

    # Marks order as ready to be picked up on pick-up point.
    #
    # Params:
    #   order_id: (String) order SlevomatID
    #   auto_mark_ready_for_pickup: (Boolean) auto mark order as ready for pick up
    #   auto_mark_delivered: (Boolean) auto mark order as delivered
    #
    # Combination of auto_mark_ready_for_pickup = false and auto_mark_delivered = true is not permitted.
    def mark_getting_ready_for_pickup(order_id, auto_mark_ready_for_pickup = false, auto_mark_delivered = false)
      endpoint_url = build_endpoint_url(order_id, 'mark-getting-ready-for-pickup')
      body = {
        autoMarkDelivered: auto_mark_delivered,
        autoMarkReadyForPickup: auto_mark_ready_for_pickup
      }
      RequestMaker.new(@partner_token, @api_secret).send_post_request(endpoint_url, body)
    end

    # Marks order as ready for pickup on pick-up point.
    #
    # Params:
    #   order_id: (String) order SlevomatID
    #   auto_mark_delivered: (Boolean) auto mark order as delivered
    def mark_ready_for_pickup(order_id, auto_mark_delivered = false)
      endpoint_url = build_endpoint_url(order_id, 'mark-ready-for-pickup')
      body = {
        autoMarkDelivered: auto_mark_delivered
      }
      RequestMaker.new(@partner_token, @api_secret).send_post_request(endpoint_url, body)
    end

    # Marks order as delivered to customer.
    #
    # Params:
    #   order_id: (String) order SlevomatID
    def mark_delivered(order_id)
      endpoint_url = build_endpoint_url(order_id, 'mark-delivered')
      RequestMaker.new(@partner_token, @api_secret).send_post_request(endpoint_url)
    end

    # Updates shipping address of order.
    #
    # Params:
    #   order_id: (String) order SlevomatID
    #   name: (String) full customer name
    #   street: (String) street name
    #   city: (String) city name
    #   postalCode: (String) ZIP code of city or city-part
    #   state: (String) state code (allowed cz or sk)
    #   phone: (String) customer phone on which transporter will call.
    #   company: (String) company name (optional)
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
      RequestMaker.new(@partner_token, @api_secret).send_post_request(endpoint_url, body)
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