# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(version: 20160711000000) do
  create_table 'domains', force: true do |t|
    t.string  'name',           null:  false, limit: 255
    t.string  'master',         limit: 128
    t.integer 'last_check'
    t.string  'type',           null:  false, limit: 6
    t.integer 'notified_serial'
    t.string  'account',        limit: 40
  end

  add_index 'domains', %w(name), unique: true

  create_table 'records', force: true do |t|
    t.integer 'domain_id'
    t.string  'name',       limit:   255
    t.string  'type',       limit:   10
    t.text    'content',    limit:   64000
    t.integer 'ttl'
    t.integer 'prio'
    t.integer 'change_date'
    t.boolean 'disabled',   default: 0
    t.binary  'ordername',  limit:   255
    t.boolean 'auth',       default: 1
  end

  add_index 'records', %w(name type)
  add_index 'records', %w(domain_id)
  add_index 'records', %w(domain_id ordername)

  create_table 'supermasters', force: true do |t|
    t.string 'ip',         limit: 64,  null: false
    t.string 'nameserver', limit: 255, null: false
    t.string 'account',    limit: 40,  null: false
  end

  create_table 'comments', force: true do |t|
    t.integer 'domain_id',   null: false
    t.string  'name',        null: false, limit: 255
    t.string  'type',        null: false, limit: 10
    t.integer 'modified_at', null: false
    t.string  'account',     null: false, limit: 40
    t.text    'comment',     null: false, limit: 64000
  end

  add_index 'comments', %w(domain_id)
  add_index 'comments', %w(name type)
  add_index 'comments', %w(domain_id modified_at)

  create_table 'domainmetadata', force: true do |t|
    t.integer 'domain_id', null: false
    t.string  'kind',      null: false, limit: 32
    t.text    'content'
  end

  add_index 'domainmetadata', %w(domain_id kind)

  create_table 'cryptokeys', force: true do |t|
    t.integer 'domain_id', null: false
    t.integer 'flags',     null: false
    t.boolean 'active'
    t.text    'content'
  end

  add_index 'cryptokeys', %w(domain_id)

  create_table 'tsigkeys', force: true do |t|
    t.string 'name',      limit: 255
    t.string 'algorithm', limit: 50
    t.string 'secret',    limit: 255
  end

  add_index 'tsigkeys', %w(name algorithm), unique: true
end
