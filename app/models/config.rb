# == Schema Information
#
# Table name: configs
#
#  id         :bigint           not null, primary key
#  key        :string           not null
#  kind       :string           not null
#  value      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_configs_on_key  (key)
#
class Config < ApplicationRecord
  class ConfigKeyNotPresentError < StandardError; end
  class ConfigKeyNotFoundError < StandardError; end
  class InvalidKeyError < StandardError; end
  class DoNotDeleteError < StandardError; end
  class MissingKindError < StandardError; end

  VALID_KEYS = /\A[a-z]([a-z0-9]+|\_)+[a-z0-9]+\z/
  KINDS = %w[Boolean Integer BigDecimal Float Date DateTime String JSON]

  validates :key, presence: true, uniqueness: true, format: { with: VALID_KEYS }
  validates :value, presence: true
  validates :kind, presence: true, inclusion: { in: KINDS }

  auto_strip_attributes :key
  auto_strip_attributes :value

  def get_value
    case kind
    when 'Boolean'.freeze
      value.downcase == 'true' || value.downcase == 't' ||  value.downcase == '1'
    when 'Integer'.freeze
      value.to_i
    when 'BigDecimal'.freeze
      BigDecimal(value)
    when 'Float'.freeze
      value.to_f
    when 'Date'.freeze
      value.to_d
    when 'DateTime'.freeze
      DateTime.parse(value)
    when 'String'.freeze
      value.to_s
    when 'JSON'.freeze
      JSON.parse(value)
    else
      raise MissingKindError
    end
  end

  def delete
    Rails.logger.error 'Prefer Config#destroy so Redis cache can be cleaned too'

    raise DoNotDeleteError
  end

  def self.get(key)
    c = Config.fetch(key.to_s)
    c.get_value if c
  end

  def self.get!(key)
    c = Config.fetch(key.to_s)
    return c.get_value if c

    raise ConfigKeyNotFoundError
  end

  def self.set(**args)
    args = args.stringify_keys.transform_values(&:to_s)

    if c = Config.find_by(key: args['key'])
      c.update!(args)
      c
    else
      Config.create!(args)
    end
  end

  def self.set_unless_key_exists!(**args)
    args = args.stringify_keys.transform_values(&:to_s)

    c = Config.where(key: args['key']).limit(1).first
    c = Config.create!(args) unless c
    c
  end

  # ModelCache.
  # 1. Add model_cache gem, lend it a redis_cache handler
  # 2. Add to this model
  #
  #   > include ModelCache
  #   > model_cache_key :key
  #
  # 3. Leave self.cache_sync as is and remove self.fetch method.
  def self.cache_sync
    Config.all.each(&:set_cache)
  end

  def self.fetch(key)
    find_by_key key
  end
end
