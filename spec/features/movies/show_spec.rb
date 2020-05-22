require 'rails_helper'

RSpec.describe "Movie show page" do
  it "user can see movie info and all actors by age" do
    studio = Studio.create(name: "Funny Studio", location: "Hollywood")
    movie = studio.movies.create(title: "Dumb n Dumber", year: "1999", genre: "Comedy")
    actor1 = movie.actors.create(name: "Kid Actor", age: 10)
    actor2 = movie.actors.create(name: "Middle Age Actor", age: 40)
    actor3 = movie.actors.create(name: "Old Actor", age: 70)
    visit "/movies/#{movie1.id}"

    expect(page).to have_content(movie.title)
    expect(page).to have_content(movie.year)
    expect(page).to have_content(movie.genre)

    within ".actors-list" do
      expect(actor1.name).to appear_berfore(actor2.name)
      expect(actor2.name).to appear_berfore(actor3.name)
      expect(page).to have_content("Average Age: 40")
    end

  end
end
