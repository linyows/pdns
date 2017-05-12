require 'test_helper'

module PDNS
  class DomainsControllerTest < ActionController::TestCase
    setup do
      @routes = Engine.routes
    end

    test 'domains show when valid' do
      Domain.new(name: 'foo.com', type: 'NATIVE').save

      get :show, params: { id: 'foo.com' }
      assert_equal 200, response.status

      domain = JSON.parse(response.body)
      assert_equal domain.keys, %w(id name master last_check type
                                   notified_serial account)

      assert_equal domain['name'], 'foo.com'
      assert_equal domain['type'], 'NATIVE'
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
