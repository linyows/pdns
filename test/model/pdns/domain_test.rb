require 'test_helper'

module PDNS
  class DomainTest < ActiveSupport::TestCase
    setup do
      @domain = Domain.new(name: 'example.com', type: 'NATIVE')
    end

    test 'domain valid' do
      assert @domain.valid?
    end

    test 'domain invalid' do
      domain = Domain.new
      domain.valid?

      assert_equal domain.errors.count, 4
      assert_includes domain.errors[:name], 'can\'t be blank'
      assert_includes domain.errors[:name], 'is invalid'
      assert_includes domain.errors[:type], 'can\'t be blank'
      assert_includes domain.errors[:type], 'is not included in the list'
    end

    test 'domain name validation' do
      @domain.name = 'example-0123456789.com'
      assert @domain.valid?

      @domain.name = 'xn--vck8cuc4a.jp'
      assert @domain.valid?

      @domain.name = 'example.co.jp'
      assert @domain.valid?

      @domain.name = 'example-.com'
      assert_not @domain.valid?

      @domain.name = 'example.xn--tckwe'
      assert @domain.valid?

      @domain.name = 'xn--vck8cuc4a.xn--tckwe'
      assert @domain.valid?

      @domain.name = 'サンプル.jp'
      assert_not @domain.valid?

      @domain.name = 'example.com'
      @domain.save
      domain = Domain.new(name: 'example.com', type: 'NATIVE')
      domain.valid?
      assert_includes domain.errors[:name], 'has already been taken'
    end
  end
end
