class Room < ApplicationRecord
  belongs_to :hostel, counter_cache: true
  
  validates :title, :short_description, :description, :price, :capacity, :size, 
            :bed, :view, :hostel, presence: true
  
  has_rich_text :description
  has_rich_text :short_description

  scope :book, -> { where(book: true) }

  extend FriendlyId
  friendly_id :title, use: :slugged

  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user }

  def to_s
    title
  end
end
