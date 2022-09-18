class Hostel < ApplicationRecord
  validates :name, presence: true
  validates :address, presence: true, length: {minimum: 5}
  validates :description, presence: true, length: {minimum: 5}

  belongs_to :user, counter_cache: true
  has_many :rooms, dependent: :destroy
  has_many :enrollments

  validates :name, uniqueness: :true
  validates :avatar, attached: true, content_type: ['image/png', 'image/jpg', 'image/jpeg'], 
            size: { between: 50.kilobyte..100.megabytes , message: 'size should be between 50KB and 100MB.' }

  scope :latest, -> { limit(3).order(created_at: :desc) }
  scope :top_rated, -> { limit(3).order(average_rating: :desc, created_at: :desc) }
  scope :popular, -> { limit(3).order(enrollments_count: :desc, created_at: :desc) }
  scope :published, -> { where(published: true) }
  scope :approved, -> { where(approved: true) }
  scope :unpublished, -> { where(published: false) }
  scope :unapproved, -> { where(approved: false) }

  has_one_attached :avatar
  
  def to_s
    name
    address
  end
  has_rich_text :description

  extend FriendlyId
  friendly_id :name, use: :slugged

  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user }

  def update_rating
    if enrollments.any? && enrollments.where.not(rating: nil).any? 
      update_column :average_rating, (enrollments.average(:rating).round(2).to_f)
    else
      update_column :average_rating, (0)
    end
  end

  # friendly_id :generated_slug, use: :slugged
  # def generated_slug
  #   require 'securerandom'
  #   @random_slug ||= persisted? ? friendly_id : SecureRandom.hex(4)
  # end

  # def to_s
  #   slug
  # end
end
