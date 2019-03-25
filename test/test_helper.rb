$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "slevomat_api"
require "webmock/minitest"
require "minitest/autorun"
require 'active_support'
require 'active_support/core_ext'

WebMock.disable_net_connect!(:allow_localhost => true)

