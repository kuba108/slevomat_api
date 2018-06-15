require 'json'
require 'faraday'
require 'faraday_middleware'

require "slevomat_api/version"
require "slevomat_api/invalid_request_type"
require 'slevomat_api/client'
require 'slevomat_api/request'
require 'slevomat_api/request_maker'
require 'slevomat_api/response'
require 'slevomat_api/response_validator'
require 'slevomat_api/error/default_error'
require 'slevomat_api/error/auto_mark_delivered'
require 'slevomat_api/error/bad_request_error'
require 'slevomat_api/error/invalid_cancel'
require 'slevomat_api/error/invalid_credentials'
require 'slevomat_api/error/invalid_request'
require 'slevomat_api/error/invalid_status_change'
require 'slevomat_api/error/order_item_not_found'
require 'slevomat_api/error/order_not_exported'
require 'slevomat_api/error/order_not_found'
require 'slevomat_api/error/other_error'
require 'slevomat_api/error/response_error'
require 'slevomat_api/error/response_parsing'

module SlevomatApi

end
