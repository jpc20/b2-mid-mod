require 'rails_helper'

RSpec.describe Actor, type: :model do
  describe "validations" do
    it {should have_many :movie_actors}
    it {should have_many(:movies).through :movie_actors}
  end

  describe 'methods' do
    it "order_by_age" do
      studio = Studio.create(name: "Funny Studio", location: "Hollywood")
      movie = studio.movies.create(title: "Dumb n Dumber", year: "1999", genre: "Comedy")
      actor3 = movie.actors.create(name: "Old Actor", age: 70)
      actor1 = movie.actors.create(name: "Kid Actor", age: 10)
      actor2 = movie.actors.create(name: "Middle Age Actor", age: 40)
      expect(Actor.order_by_age).to eq([actor1, actor2, actor3])
    end
  end
end
