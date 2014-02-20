# == Schema Information
#
# Table name: cats
#
#  id         :integer          not null, primary key
#  age        :integer
#  birthdate  :date             not null
#  color      :string(255)
#  name       :string(255)      not null
#  sex        :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

class Cat < ActiveRecord::Base
  validates :birthdate, :name, :sex, :presence =>true
  validates :age, numericality: { only_integer: true }
  validates :color, inclusion: { in: %w(Black White Brown Tabby) }
  validates :sex, inclusion: { in: %w(M F) }

  has_many :cat_rental_requests, dependent: :destroy
end
