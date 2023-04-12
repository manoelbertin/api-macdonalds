require "rails_helper"

class Validatable
  include ActiveModel::Validations
  attr_accessor :date
  validates :date, future_date: true
end