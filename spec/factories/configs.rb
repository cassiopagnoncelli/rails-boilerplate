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
FactoryBot.define do
  factory :config do
    key { 'counter' }
    value { '55' }
    kind { 'Integer' }
  end
end
