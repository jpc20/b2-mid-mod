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

    it "average_age" do
      studio = Studio.create(name: "Funny Studio", location: "Hollywood")
      movie = studio.movies.create(title: "Dumb n Dumber", year: "1999", genre: "Comedy")
      actor3 = movie.actors.create(name: "Old Actor", age: 70)
      actor1 = movie.actors.create(name: "Kid Actor", age: 10)
      actor2 = movie.actors.create(name: "Middle Age Actor", age: 40)
      expect(Actor.average_age).to eq(40)
    end

    it "actors_worked_with" do
      studio = Studio.create(name: "Funny Studio", location: "Hollywood")
      movie = studio.movies.create(title: "Dumb n Dumber", year: "1999", genre: "Comedy")
      movie2 = studio.movies.create(title: "New movie", year: "1999", genre: "Comedy")
      movie3 = studio.movies.create(title: "Another movie", year: "1999", genre: "Comedy")

      actor1 = movie.actors.create(name: "Kid Actor", age: 10)

      actor3 = movie.actors.create(name: "Old Actor", age: 70)
      actor2 = movie.actors.create(name: "Middle Age Actor", age: 40)
      
      movie2.actors << actor1
      actor5 = movie2.actors.create(name: "Cool Actor", age: 40)

      actor4 = movie3.actors.create(name: "Actor", age: 40)

      expect(actor1.actors_worked_with).to include(actor3)
      expect(actor1.actors_worked_with).to include(actor2)
      expect(actor1.actors_worked_with).to include(actor5)
      expect(actor1.actors_worked_with).to_not include(actor4)
    end
  end
end
