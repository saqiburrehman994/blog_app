class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_one_attached :image
  validates :image, presence: true
  belongs_to :category, optional: true
  has_many  :liked_by, through: :likes, source: :user
  has_rich_text :content

  after_initialize  :set_defaults
  scope :published, -> { where(published: true)}
  scope :scheduled, -> { where(published: false)}

  private
  def set_defaults
    self.view_count ||= 0
  end
end
