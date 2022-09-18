class Enrollment < ApplicationRecord
  belongs_to :hostel, counter_cache: true
  belongs_to :user, counter_cache: true

  validates :user, :hostel, presence: true

  validates_presence_of :rating, if: :review?
  validates_presence_of :review, if: :rating?

  validates_uniqueness_of :user_id, scope: :hostel_id  #user cant be subscribed to the same hostel twice
  validates_uniqueness_of :hostel_id, scope: :user_id  #user cant be subscribed to the same hostel twice

  validate :cant_subscribe_to_own_hostel

  scope :reviewed, -> { where.not(rating: [0, nil, ""]) }
  scope :latest_reviews, -> { reviewed.order(rating: :desc, created_at: :desc).limit(3) }

  extend FriendlyId
  friendly_id :to_s, use: :slugged

  def to_s
    user.to_s + " " + hostel.to_s
  end

  after_save do 
    unless rating.nil? || rating.zero?
      hostel.update_rating
    end
  end

  after_destroy do 
    hostel.update_rating
  end

  protected
  def cant_subscribe_to_own_hostel
    if self.new_record?
      if self.user_id.present?
        if user_id == hostel.user_id
          errors.add(:base, "You can not subscribe to your own hotel")
        end
      end
    end
  end

end
