require 'test_helper'

module PDNS
  class DomainTest < ActiveSupport::TestCase
    test 'valid with a name, type' do
      domain = Domain.new(name: 'example.com', type: 'NATIVE')
      assert domain.valid?
    end

    test 'invalid without a name' do
      domain = Domain.new(type: 'NATIVE')
      domain.valid?
      assert_includes domain.errors[:name], 'can\'t be blank'
    end

    test 'valid without a type' do
      domain = Domain.new(name: 'example.com')
      assert domain.valid?
    end

    test 'valid when name is example-0123456789.com' do
      domain = Domain.new(name: 'example-0123456789.com')
      assert domain.valid?
    end

    test 'valid when name is xn--vck8cuc4a.jp' do
      domain = Domain.new(name: 'xn--vck8cuc4a.jp')
      assert domain.valid?
    end

    test 'valid when name is example.co.jp' do
      domain = Domain.new(name: 'example.co.jp')
      assert domain.valid?
    end

    test 'invalid when name is example-.com' do
      domain = Domain.new(name: 'example-.com')
      domain.valid?
      assert_includes domain.errors[:name], 'is invalid'
    end

    test 'invalid when name is -example.com' do
      domain = Domain.new(name: '-example.com')
      domain.valid?
      assert_includes domain.errors[:name], 'is invalid'
    end

    test 'invalid when name is サンプル.jp' do
      domain = Domain.new(name: 'サンプル.jp')
      domain.valid?
      assert_includes domain.errors[:name], 'is invalid'
    end

    test 'invalid when same record is registered' do
      Domain.new(name: 'example.com').save
      domain = Domain.new(name: 'example.com', type: 'NATIVE')
      domain.valid?
      assert_includes domain.errors[:name], 'has already been taken'
    end

    test 'valid when name is example.xn--tckwe' do
      domain = Domain.new(name: 'example.xn--tckwe')
      assert domain.valid?
    end

    test 'valid when name is xn--vck8cuc4a.xn--tckwe' do
      domain = Domain.new(name: 'xn--vck8cuc4a.xn--tckwe')
      assert domain.valid?
    end
  end
end
