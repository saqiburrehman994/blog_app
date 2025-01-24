class Profile < ApplicationRecord
  belongs_to :user
  enum :gender, [ :male, :female, :other]
  has_one_attached :avator
end
