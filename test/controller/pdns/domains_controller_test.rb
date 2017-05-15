require 'test_helper'

module PDNS
  class DomainsControllerTest < ActionController::TestCase
    setup do
      @routes = Engine.routes
    end

    test 'domains index when domain exists' do
      Domain.new(name: 'foo.com', type: 'NATIVE', account: 'foo').save
      Domain.new(name: 'foo.net', type: 'NATIVE', account: 'foo').save
      Domain.new(name: 'bar.co.jp', type: 'NATIVE', account: 'bar').save

      get :index, params: { account: 'foo' }
      assert_equal 200, response.status

      domains = JSON.parse(response.body)
      assert_equal 2, domains.length
      assert_equal 'foo.com', domains.first['name']
      assert_equal 'foo.net', domains.last['name']
    end

    test 'domains index when domain not exists' do
      get :index
      assert_equal 200, response.status

      body = JSON.parse(response.body)
      assert_equal [], body
    end

    test 'domains show when valid' do
      Domain.new(name: 'foo.com', type: 'NATIVE').save

      get :show, params: { id: 'foo.com' }
      assert_equal 200, response.status

      domain = JSON.parse(response.body)
      assert_equal %w(id name master last_check type
        notified_serial account), domain.keys

      assert_equal 'foo.com', domain['name']
      assert_equal 'NATIVE', domain['type']
      assert_nil domain['last_check']
      assert_nil domain['notified_serial']
      assert_nil domain['account']
      assert_nil domain['master']
    end

    test 'domains show when not found' do
      assert_raises ActiveRecord::RecordNotFound do
        get :show, params: { id: 'foo.com' }
      end
    end

    test 'domains show when invalid id' do
      assert_raises ActionController::UrlGenerationError do
        get :show, params: { id: '//foo.com' }
      end
    end
  end
end
