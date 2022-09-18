class HomeController < ApplicationController
  skip_before_action :authenticate_user!, :only => [:index]
  def index
    @hostels = Hostel.all.limit(3)
    @latest = Hostel.latest.published.approved
    # @latest_good_reviews = Enrollment.latest_reviews
    @latest_good_reviews = Enrollment.order(rating: :desc, created_at: :desc).limit(3)
    @top_rated = Hostel.top_rated.published.approved
    @popular = Hostel.popular.published.approved 
  end

  def activity
    if current_user.has_role?(:admin)
      @pagy, @activities = pagy(PublicActivity::Activity.all.order(created_at: :desc))
    else 
      redirect_to root_path, alert: "You are not authorized to access this page"
    end
  end
end
