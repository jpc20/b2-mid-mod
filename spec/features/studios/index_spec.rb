require 'rails_helper'

RSpec.describe "Studio Index" do
  it "user can see all studios and the name of their movies" do
    studio1 = Studio.create(name: "Funny", location: "Hollywood")
    studio2 = Studio.create(name: "Action", location: "LA")
    movie1 = studio1.movies.create(title: "Dumb n Dumber", year: "1999")
    movie2 = studio1.movies.create(title: "Austin Powers", year: "2001")
    movie3 = studio1.movies.create(title: "Mission Impossible", year: "2004")
    movie4 = studio1.movies.create(title: "The Bourne Identity", year: "2001")
    visit '/studios'

    within ".studio-#{studio1.id}" do
      expect(page).to have_content(studio1.name)
      expect(page).to have_content(movie1.title)
      expect(page).to have_content(movie2.title)
    end

    within "studio-#{studio2.id}" do
      expect(page).to have_content(studio2.name)
      expect(page).to have_content(movie3.title)
      expect(page).to have_content(movie4.title)
    end
  end

end
