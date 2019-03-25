require "test_helper"

class SlevomatApiTest < Minitest::Test


  def test_that_it_has_a_version_number
    refute_nil ::SlevomatApi::VERSION
  end

  def test_cancel_order_positive
    api_url = 'http://api_test.com'
    order_id = 123456
    partner_token = "some_token"
    api_secret = "api_secret"
    order_items = [{'slevomatId': '45454', 'amount': 1}]
    client = SlevomatApi::Client.new(partner_token, api_secret, api_url)

    stub_request(:post, "http://api_test.com/v1/order/123456/cancel").
        with(
            body: "{\"items\":[{\"slevomatId\":\"45454\",\"amount\":1}],\"note\":\"yes\"}",
            headers: {
                'Content-Type' => 'application/json',
                'X-Apisecret' => 'api_secret',
                'User-Agent' => "SlevomatZboziApiClient/Ruby #{RUBY_VERSION}",
                'X-Partnertoken' => 'some_token'
            }).
        to_return(status: 200, body: "{}", headers: {})

    response = client.cancel_order(order_id, order_items, "yes")

    assert_equal(true, response)
  end

  def test_mark_pending_positive
    api_url = 'http://api_test.com'
    order_id = 123456
    partner_token = "some_token"
    api_secret = "api_secret"
    client = SlevomatApi::Client.new(partner_token, api_secret, api_url)

    stub_request(:post, "http://api_test.com/v1/order/#{order_id}/mark-pending").
        with(
            body: "null",
            headers: {
                'Content-Type' => 'application/json',
                'X-Apisecret' => 'api_secret',
                'User-Agent' => "SlevomatZboziApiClient/Ruby #{RUBY_VERSION}",
                'X-Partnertoken' => 'some_token'
            }).
        to_return(status: 200, body: "{}", headers: {})

    response = client.mark_pending(order_id)

    assert_equal(true, response)
  end

  def test_mark_en_route_positive
    api_url = 'http://api_test.com'
    order_id = 123456
    partner_token = "some_token"
    api_secret = "api_secret"
    client = SlevomatApi::Client.new(partner_token, api_secret, api_url)

    stub_request(:post, "http://api_test.com/v1/order/#{order_id}/mark-en-route").
        with(
            body: "{\"autoMarkDelivered\":true}",
            headers: {
                'Content-Type' => 'application/json',
                'X-Apisecret' => 'api_secret',
                'User-Agent' => "SlevomatZboziApiClient/Ruby #{RUBY_VERSION}",
                'X-Partnertoken' => 'some_token'
            }).
        to_return(status: 200, body: '{"expectedDeliveryDate": "2019-03-04"}', headers: {})

    response = client.mark_en_route(order_id, true)

    assert_equal(true, response)
  end

  def test_mark_getting_ready_for_pickup_positive
    api_url = 'http://api_test.com'
    order_id = 123456
    partner_token = "some_token"
    api_secret = "api_secret"
    client = SlevomatApi::Client.new(partner_token, api_secret, api_url)

    stub_request(:post, "http://api_test.com/v1/order/#{order_id}/mark-getting-ready-for-pickup").
        with(
            body: "{\"autoMarkDelivered\":false,\"autoMarkReadyForPickup\":false}",
            headers: {
                'Content-Type' => 'application/json',
                'User-Agent' => "SlevomatZboziApiClient/Ruby #{RUBY_VERSION}",
                'X-Apisecret' => 'api_secret',
                'X-Partnertoken' => 'some_token'
            }).
        to_return(status: 200, body: '{"expectedDeliveryDate": "2019-03-04"}', headers: {})

    response = client.mark_getting_ready_for_pickup(order_id)

    assert_equal(true, response)
  end

  def test_mark_ready_for_pickup_positive
    api_url = 'http://api_test.com'
    order_id = 123456
    partner_token = "some_token"
    api_secret = "api_secret"
    client = SlevomatApi::Client.new(partner_token, api_secret, api_url)

    stub_request(:post, "http://api_test.com/v1/order/#{order_id}/mark-ready-for-pickup").
        with(
            body: "{\"autoMarkDelivered\":true}",
            headers: {
                'Content-Type' => 'application/json',
                'User-Agent' => "SlevomatZboziApiClient/Ruby #{RUBY_VERSION}",
                'X-Apisecret' => 'api_secret',
                'X-Partnertoken' => 'some_token'
            }).
        to_return(status: 200, body: '{"expectedDeliveryDate": "2019-03-04"}', headers: {})

    response = client.mark_ready_for_pickup(order_id, true)

    assert_equal(true, response)
  end

  def test_mark_delivered_positive
    api_url = 'http://api_test.com'
    order_id = 123456
    partner_token = "some_token"
    api_secret = "api_secret"
    client = SlevomatApi::Client.new(partner_token, api_secret, api_url)

    stub_request(:post, "http://api_test.com/v1/order/#{order_id}/mark-delivered").
        with(
            body: "null",
            headers: {
                'Content-Type' => 'application/json',
                'User-Agent' => "SlevomatZboziApiClient/Ruby #{RUBY_VERSION}",
                'X-Apisecret' => 'api_secret',
                'X-Partnertoken' => 'some_token'
            }).
        to_return(status: 200, body: '{}', headers: {})

    response = client.mark_delivered(order_id)

    assert_equal(true, response)
  end

  def test_update_shipping_address_positive
    api_url = 'http://api_test.com'
    order_id = 123456
    partner_token = "some_token"
    api_secret = "api_secret"
    name = "Name"
    street = "street"
    city = "city"
    state = "US"
    phone = "+420123456789"
    company = "company"

    client = SlevomatApi::Client.new(partner_token, api_secret, api_url)

    stub_request(:post, "http://api_test.com/v1/order/#{order_id}/update-shipping-address").
        with(
            body: "{\"name\":\"Name\",\"street\":\"street\",\"city\":\"city\",\"state\":\"US\",\"phone\":\"+420123456789\",\"postalCode\":\"company\",\"company\":null}",
            headers: {
                'Content-Type' => 'application/json',
                'User-Agent' => "SlevomatZboziApiClient/Ruby #{RUBY_VERSION}",
                'X-Apisecret' => 'api_secret',
                'X-Partnertoken' => 'some_token'
            }).
        to_return(status: 200, body: '', headers: {})

    response = client.update_shipping_address(order_id, name, street, city, state, phone, company)
    assert_equal(true, response)
  end

  def test_raise_page_not_found_response_error
    api_url = 'http://api_test.com'
    order_id = 123456
    partner_token = "some_token"
    api_secret = "api_secret"
    order_items = [{'slevomatId': '45454', 'amount': 1}]
    client = SlevomatApi::Client.new(partner_token, api_secret, api_url)

    stub_request(:post, "http://api_test.com/v1/order/123456/cancel").
        with(
            body: "{\"items\":[{\"slevomatId\":\"45454\",\"amount\":1}],\"note\":\"yes\"}",
            headers: {
                'Content-Type' => 'application/json',
                'User-Agent' => "SlevomatZboziApiClient/Ruby #{RUBY_VERSION}",
                'X-Apisecret' => 'api_secret',
                'X-Partnertoken' => 'some_token'
            }).
        to_return(status: 404, body: '{}', headers: {})

    ex = assert_raises SlevomatApi::Error::ResponseError do
      client.cancel_order(order_id, order_items, "yes")
    end


    assert_equal("Slevomat API returned 404 - Page not found. Please check your API URL.", ex.message)
  end

  def test_raise_status_missing_error
    api_url = 'http://api_test.com'
    order_id = 123456
    partner_token = "some_token"
    partner_secret = "api_secret"
    order_items = [{'slevomatId': '45454', 'amount': 1}]
    client = SlevomatApi::Client.new(partner_token, partner_secret, api_url)

    stub_request(:post, "http://api_test.com/v1/order/123456/cancel").
        with(
            body: "{\"items\":[{\"slevomatId\":\"45454\",\"amount\":1}],\"note\":\"yes\"}",
            headers: {
                'Content-Type' => 'application/json',
                'User-Agent' => "SlevomatZboziApiClient/Ruby #{RUBY_VERSION}",
                'X-Apisecret' => 'api_secret',
                'X-Partnertoken' => 'some_token'
            }).
        to_return(status: 400, body: '{"status":, "messages":["Order #1234 was not found."]}', headers: {})

    ex = assert_raises SlevomatApi::Error::ResponseError do
      client.cancel_order(order_id, order_items, "yes")
    end

    assert_equal("Slevomat API invalid 400 response: missing status.", ex.message)

  end

  def test_raise_messages_missing_error
    api_url = 'http://api_test.com'
    order_id = 123456
    partner_token = "some_token"
    partner_secret = "api_secret"
    order_items = [{'slevomatId': '45454', 'amount': 1}]
    client = SlevomatApi::Client.new(partner_token, partner_secret, api_url)

    stub_request(:post, "http://api_test.com/v1/order/123456/cancel").
        with(
            body: "{\"items\":[{\"slevomatId\":\"45454\",\"amount\":1}],\"note\":\"yes\"}",
            headers: {
                'Content-Type' => 'application/json',
                'User-Agent' => "SlevomatZboziApiClient/Ruby #{RUBY_VERSION}",
                'X-Apisecret' => 'api_secret',
                'X-Partnertoken' => 'some_token'
            }).
        to_return(status: 400, body: '{"status": 3, "messages":[]}', headers: {})

    ex = assert_raises SlevomatApi::Error::ResponseError do
      client.cancel_order(order_id, order_items, "yes")
    end

    assert_equal("Slevomat API invalid 400 response: missing messages.", ex.message)
  end

  def test_reaise_bad_response_error
    api_url = 'http://api_test.com'
    order_id = 123456
    partner_token = "some_token"
    partner_secret = "api_secret"
    order_items = [{'slevomatId': '45454', 'amount': 1}]
    client = SlevomatApi::Client.new(partner_token, partner_secret, api_url)

    stub_request(:post, "http://api_test.com/v1/order/123456/cancel").
        with(
            body: "{\"items\":[{\"slevomatId\":\"45454\",\"amount\":1}],\"note\":null}",
            headers: {
                'Content-Type' => 'application/json',
                'User-Agent' => "SlevomatZboziApiClient/Ruby #{RUBY_VERSION}",
                'X-Apisecret' => 'api_secret',
                'X-Partnertoken' => 'some_token'
            }).
        to_return(status: 400, body: '{"status": 1, "messages":["Nevalidní požadavek - chybějící nebo nevalidní hodnoty."]}', headers: {})

    ex = assert_raises SlevomatApi::Error::BadRequestError do
      client.cancel_order(order_id, order_items)
    end

    assert_equal(["Nevalidní požadavek - chybějící nebo nevalidní hodnoty."], ex.message)
  end

  def test_raise_wrong_credentials_error
    api_url = 'http://api_test.com'
    order_id = 123456
    partner_token = "bad_token"
    partner_secret = "bad_secret"
    order_items = [{'slevomatId': '45454', 'amount': 1}]
    client = SlevomatApi::Client.new(partner_token, partner_secret, api_url)

    stub_request(:post, "http://api_test.com/v1/order/123456/cancel").
        with(
            body: "{\"items\":[{\"slevomatId\":\"45454\",\"amount\":1}],\"note\":null}",
            headers: {
                'Content-Type' => 'application/json',
                'User-Agent' => "SlevomatZboziApiClient/Ruby #{RUBY_VERSION}",
                'X-Apisecret' => 'bad_secret',
                'X-Partnertoken' => 'bad_token'
            }).
        to_return(status: 403, body: '{"status": 2, "messages":["Neplatné přihlašovací údaje."]}', headers: {})

    ex = assert_raises SlevomatApi::Error::InvalidCredentials do
      client.cancel_order(order_id, order_items)
    end

    assert_equal(["Neplatné přihlašovací údaje."], ex.message)
  end

  def test_raise_order_not_found_error
    api_url = 'http://api_test.com'
    order_id = 123456
    partner_token = "some_token"
    partner_secret = "api_secret"
    order_items = [{'slevomatId': '45454', 'amount': 1}]
    client = SlevomatApi::Client.new(partner_token, partner_secret, api_url)

    stub_request(:post, "http://api_test.com/v1/order/123456/cancel").
        with(
            body: "{\"items\":[{\"slevomatId\":\"45454\",\"amount\":1}],\"note\":null}",
            headers: {
                'Content-Type' => 'application/json',
                'User-Agent' => "SlevomatZboziApiClient/Ruby #{RUBY_VERSION}",
                'X-Apisecret' => 'api_secret',
                'X-Partnertoken' => 'some_token'
            }).
        to_return(status: 422, body: '{"status": 3, "messages":["Neexistující objednávka."]}', headers: {})

    ex = assert_raises SlevomatApi::Error::OrderNotFound do
      client.cancel_order(order_id, order_items)
    end

    assert_equal(["Neexistující objednávka."], ex.message)
  end

  def test_raise_order_item_not_found_error
    api_url = 'http://api_test.com'
    order_id = 123456
    partner_token = "some_token"
    partner_secret = "api_secret"
    order_items = [{'slevomatId': '45454', 'amount': 1}]
    client = SlevomatApi::Client.new(partner_token, partner_secret, api_url)

    stub_request(:post, "http://api_test.com/v1/order/123456/cancel").
        with(
            body: "{\"items\":[{\"slevomatId\":\"45454\",\"amount\":1}],\"note\":null}",
            headers: {
                'Content-Type' => 'application/json',
                'User-Agent' => "SlevomatZboziApiClient/Ruby #{RUBY_VERSION}",
                'X-Apisecret' => 'api_secret',
                'X-Partnertoken' => 'some_token'
            }).
        to_return(status: 422, body: '{"status": 4, "messages":["Neexistující položka objednávky."]}', headers: {})

    ex = assert_raises SlevomatApi::Error::OrderItemNotFound do
      client.cancel_order(order_id, order_items)
    end

    assert_equal(["Neexistující položka objednávky."], ex.message)
  end

  def test_invalid_status_change_error
    api_url = 'http://api_test.com'
    order_id = 123456
    partner_token = "some_token"
    partner_secret = "api_secret"
    order_items = [{'slevomatId': '45454', 'amount': 1}]
    client = SlevomatApi::Client.new(partner_token, partner_secret, api_url)

    stub_request(:post, "http://api_test.com/v1/order/123456/cancel").
        with(
            body: "{\"items\":[{\"slevomatId\":\"45454\",\"amount\":1}],\"note\":null}",
            headers: {
                'Content-Type' => 'application/json',
                'User-Agent' => "SlevomatZboziApiClient/Ruby #{RUBY_VERSION}",
                'X-Apisecret' => 'api_secret',
                'X-Partnertoken' => 'some_token'
            }).
        to_return(status: 422, body: '{"status": 5, "messages":["Přechod objednávky do nepovoleného stavu."]}', headers: {})

    ex = assert_raises SlevomatApi::Error::InvalidStatusChange do
      client.cancel_order(order_id, order_items)
    end

    assert_equal(["Přechod objednávky do nepovoleného stavu."], ex.message)
  end

  def test_invalid_cancel_error
    api_url = 'http://api_test.com'
    order_id = 123456
    partner_token = "some_token"
    partner_secret = "api_secret"
    order_items = [{'slevomatId': '45454', 'amount': 1}]
    client = SlevomatApi::Client.new(partner_token, partner_secret, api_url)

    stub_request(:post, "http://api_test.com/v1/order/123456/cancel").
        with(
            body: "{\"items\":[{\"slevomatId\":\"45454\",\"amount\":1}],\"note\":null}",
            headers: {
                'Content-Type' => 'application/json',
                'User-Agent' => "SlevomatZboziApiClient/Ruby #{RUBY_VERSION}",
                'X-Apisecret' => 'api_secret',
                'X-Partnertoken' => 'some_token'
            }).
        to_return(status: 422, body: '{"status": 6, "messages":["Neplatné storno - stornování většího počtu položek, než existuje."]}', headers: {})

    ex = assert_raises SlevomatApi::Error::InvalidCancel do
      client.cancel_order(order_id, order_items)
    end

    assert_equal(["Neplatné storno - stornování většího počtu položek, než existuje."], ex.message)
  end

  def test_other_error_raised
    api_url = 'http://api_test.com'
    order_id = 123456
    partner_token = "some_token"
    partner_secret = "api_secret"
    order_items = [{'slevomatId': '45454', 'amount': 1}]
    client = SlevomatApi::Client.new(partner_token, partner_secret, api_url)

    stub_request(:post, "http://api_test.com/v1/order/123456/cancel").
        with(
            body: "{\"items\":[{\"slevomatId\":\"45454\",\"amount\":1}],\"note\":null}",
            headers: {
                'Content-Type' => 'application/json',
                'User-Agent' => "SlevomatZboziApiClient/Ruby #{RUBY_VERSION}",
                'X-Apisecret' => 'api_secret',
                'X-Partnertoken' => 'some_token'
            }).
        to_return(status: 422, body: '{"status": 7, "messages":["Jiná chyba."]}', headers: {})

    ex = assert_raises SlevomatApi::Error::OtherError do
      client.cancel_order(order_id, order_items)
    end

    assert_equal(["Jiná chyba."], ex.message)
  end

  def test_order_not_exported_error
    api_url = 'http://api_test.com'
    order_id = 123456
    partner_token = "some_token"
    api_secret = "api_secret"
    client = SlevomatApi::Client.new(partner_token, api_secret, api_url)

    stub_request(:post, "http://api_test.com/v1/order/#{order_id}/mark-delivered").
        with(
            body: "null",
            headers: {
                'Content-Type' => 'application/json',
                'User-Agent' => "SlevomatZboziApiClient/Ruby #{RUBY_VERSION}",
                'X-Apisecret' => 'api_secret',
                'X-Partnertoken' => 'some_token'
            }).
        to_return(status: 422, body: '{"status": 8, "messages":["Objednávka nebyla ještě exportována do partnerského API - nelze s ní skrze API manipulovat"]}', headers: {})

    ex = assert_raises SlevomatApi::Error::OrderNotExported do
      response = client.mark_delivered(order_id)
    end

    assert_equal(["Objednávka nebyla ještě exportována do partnerského API - nelze s ní skrze API manipulovat"], ex.message)
  end

  def test_other_erroro_raise
    api_url = 'http://api_test.com'
    order_id = 123456
    partner_token = "some_token"
    api_secret = "api_secret"
    client = SlevomatApi::Client.new(partner_token, api_secret, api_url)

    stub_request(:post, "http://api_test.com/v1/order/#{order_id}/mark-en-route").
        with(
            body: "{\"autoMarkDelivered\":true}",
            headers: {
                'Content-Type' => 'application/json',
                'User-Agent' => "SlevomatZboziApiClient/Ruby #{RUBY_VERSION}",
                'X-Apisecret' => 'api_secret',
                'X-Partnertoken' => 'some_token'
            }).
        to_return(status: 422, body: '{"status": 9, "messages":["Pro automatické nastavení stavu Zboží doručeno zákazníkovi je třeba zásilku nechat automaticky nastavit do stavu Zboží připraveno k vyzvednutí"]}', headers: {})


    ex = assert_raises SlevomatApi::Error::DefaultError do
      client.mark_en_route(order_id, true)
    end


    assert_equal(["Pro automatické nastavení stavu Zboží doručeno zákazníkovi je třeba zásilku nechat automaticky nastavit do stavu Zboží připraveno k vyzvednutí"], ex.message)
  end

  def test_raise_response_error
    api_url = 'http://api_test.com'
    order_id = 123456
    partner_token = "some_token"
    partner_secret = "api_secret"
    order_items = [{'slevomatId': '45454', 'amount': 1}]
    client = SlevomatApi::Client.new(partner_token, partner_secret, api_url)

    stub_request(:post, "http://api_test.com/v1/order/123456/cancel").
        with(
            body: "{\"items\":[{\"slevomatId\":\"45454\",\"amount\":1}],\"note\":null}",
            headers: {
                'Content-Type' => 'application/json',
                'User-Agent' => "SlevomatZboziApiClient/Ruby #{RUBY_VERSION}",
                'X-Apisecret' => 'api_secret',
                'X-Partnertoken' => 'some_token'
            }).
        to_return(status: 504, body: '{}', headers: {})

    ex = assert_raises SlevomatApi::Error::ResponseError do
      client.cancel_order(order_id, order_items)
    end

    assert_equal("Slevomat API responded with unexpected HTTP status code: 504.", ex.message)
  end

  # Allowing web connect for integration tests.
  WebMock.allow_net_connect!

  def test_integrate_cancel_order_invalid_credentials
    api_url = 'https://www.slevomat.cz/zbozi-api'
    order_id = 123456
    partner_token = "custom_token"
    api_secret = "custom_api_secret"
    order_items = [{'slevomatId': '45454', 'amount': 1}]
    client = SlevomatApi::Client.new(partner_token, api_secret, api_url, 'v1', true)

    ex = assert_raises SlevomatApi::Error::InvalidCredentials do
      client.cancel_order(order_id, order_items, "Because we can")
    end

    assert_equal(["Invalid credentials."], ex.message)
  end

  def test_integrate_cancel_order_positive
    api_url = 'https://www.slevomat.cz/zbozi-api'
    order_id = 123456
    partner_token = "token" # Use production partner token
    api_secret = "secret" # Use production api secret
    order_items = [{'slevomatId': '45454', 'amount': 1}]
    client = SlevomatApi::Client.new(partner_token, api_secret, api_url, 'v1', true)

    response = client.cancel_order(order_id, order_items, "Because we can")

    assert_equal(true, response)
  end

  def test_integrate_mark_pending_positive
    api_url = 'https://www.slevomat.cz/zbozi-api'
    order_id = 123456
    partner_token = "token" # Use production partner token
    api_secret = "secret" # Use production api secret
    client = SlevomatApi::Client.new(partner_token, api_secret, api_url, 'v1', true)

    response = client.mark_pending(order_id)

    assert_equal(true, response)
  end

  def test_integrate_mark_en_route_positive
    api_url = 'https://www.slevomat.cz/zbozi-api'
    order_id = 123456
    partner_token = "token" # Use production partner token
    api_secret = "secret" # Use production api secret
    client = SlevomatApi::Client.new(partner_token, api_secret, api_url, 'v1', true)

    response = client.mark_en_route(order_id, true)

    assert_equal(true, response)
  end

  def test_inetgrate_mark_getting_ready_for_pickup_positive
    api_url = 'https://www.slevomat.cz/zbozi-api'
    order_id = 123456
    partner_token = "token" # Use production partner token
    api_secret = "secret" # Use production api secret
    client = SlevomatApi::Client.new(partner_token, api_secret, api_url, 'v1', true)

    response = client.mark_getting_ready_for_pickup(order_id)

    assert_equal(true, response)
  end

  def test_integrate_mark_ready_for_pickup_positive
    api_url = 'https://www.slevomat.cz/zbozi-api'
    order_id = 123456
    partner_token = "token" # Use production partner token
    api_secret = "secret" # Use production api secret
    client = SlevomatApi::Client.new(partner_token, api_secret, api_url, 'v1', true)

    response = client.mark_ready_for_pickup(order_id, true)

    assert_equal(true, response)
  end

  def test_integrate_mark_delivered_positive
    api_url = 'https://www.slevomat.cz/zbozi-api'
    order_id = 123456
    partner_token = "token" # Use production partner token
    api_secret = "secret" # Use production api secret
    client = SlevomatApi::Client.new(partner_token, api_secret, api_url, 'v1', true)

    response = client.mark_delivered(order_id)

    assert_equal(true, response)
  end

  def test_integrate_update_shipping_address_positive
    api_url = 'https://www.slevomat.cz/zbozi-api'
    order_id = 123456
    partner_token = "token" # Use production partner token
    api_secret = "secret" # Use production api secret
    name = "Name"
    street = "street"
    city = "city"
    state = "CZ"
    phone = "+420777888999"
    company = "company"
    postal_code = "15700"

    client = SlevomatApi::Client.new(partner_token, api_secret, api_url, 'v1', true)

    response = client.update_shipping_address(order_id, name, street, city, state, phone, postal_code, company)
    assert_equal(true, response)
  end

  def test_integrate_update_shipping_address_negative
    api_url = 'https://www.slevomat.cz/zbozi-api'
    order_id = 123456
    partner_token = "token" # Use production partner token
    api_secret = "secret" # Use production api secret
    name = "Name"
    street = "street"
    city = "city"
    state = "US"
    phone = "+420777888999"
    company = "company"
    postal_code = "15700"

    client = SlevomatApi::Client.new(partner_token, api_secret, api_url, 'v1', true)

    ex = assert_raises SlevomatApi::Error::BadRequestError do
      client.update_shipping_address(order_id, name, street, city, state, phone, postal_code, company)
    end

    assert_equal(["Invalid value of 'state' key. Allowed values: CZ, SK."], ex.message)
  end

  def test_integrate_cancel_order_negative
    api_url = 'https://www.slevomat.cz/zbozi-api'
    order_id = 123456
    partner_token = "token" # Use production partner token
    api_secret = "secret" # Use production api secret
    order_items = [{'slevomatId': '45454'}]
    client = SlevomatApi::Client.new(partner_token, api_secret, api_url, 'v1', true)

    ex = assert_raises SlevomatApi::Error::BadRequestError do
      client.cancel_order(order_id, order_items, "Because we can")
    end

    assert_equal(["Invalid 'items', row 1. Missing 'amount' key."], ex.message)
  end
end