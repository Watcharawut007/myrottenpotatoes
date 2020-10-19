class Movie < ActiveRecord::Base
    has_many :reviews
    has_one_attached :avatar
    scope :with_good_reviews, lambda { |threshold|
    Movie.joins(:reviews).group(:movie_id).
      having(['AVG(reviews.potatoes) > ?', threshold.to_i])
    }
    def name_with_rating
      "#{self.title} (#{self.rating})"
    end
  
end
