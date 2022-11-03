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
require 'rails_helper'

RSpec.describe Config, type: :model do
  describe "setter, getter" do
    subject { create :config }

    it "cannot be deleted" do
      expect { subject.delete }.to raise_exception(Config::DoNotDeleteError)
    end

    it "gets proper value" do
      expect(subject.get_value).to be_eql(subject.value.to_i)
    end

    it "sets new value" do
      Config.set key: subject.key, value: '80', kind: 'Integer'
      subject.reload
      expect(subject.get_value).to be_eql(80)
    end

    it "cannot accept empty or invalid key" do
      expect {
        Config.set value: '10', kind: 'Integer'
      }.to raise_exception(ActiveRecord::RecordInvalid)

      expect {
        Config.set key: '', value: '10', kind: 'Integer'
      }.to raise_exception(ActiveRecord::RecordInvalid)

      expect {
        Config.set key: ' a#', value: '10', kind: 'Integer'
      }.to raise_exception(ActiveRecord::RecordInvalid)
    end

    it "cannot accept empty value" do
      expect {
        Config.set key: 'abc', value: '', kind: 'Integer'
      }.to raise_exception(ActiveRecord::RecordInvalid)

      expect {
        Config.set key: 'abc', kind: 'Integer'
      }.to raise_exception(ActiveRecord::RecordInvalid)
    end

    it "cannot accept empty or invalid kind" do
      expect {
        Config.set key: 'abc', value: '10'
      }.to raise_exception(ActiveRecord::RecordInvalid)

      expect {
        Config.set key: 'abc', value: '10', kind: ''
      }.to raise_exception(ActiveRecord::RecordInvalid)

      expect {
        Config.set key: 'abc', value: '10', kind: 'Integeeeer'
      }.to raise_exception(ActiveRecord::RecordInvalid)
    end
  end
end
