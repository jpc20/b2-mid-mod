class Actor < ApplicationRecord
  has_many :movie_actors
  has_many :movies, through: :movie_actors

  def self.order_by_age
    order(:age)
  end

  def self.average_age
    average(:age)
  end

  def actors_worked_with
    Actor.joins(:movies)
          .where("movie_actors.movie_id IN (?)", movies.map(&:id))
          .where("movie_actors.actor_id <> ?", id)
          .distinct
  end

end
