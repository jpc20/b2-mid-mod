require 'rails_helper'

RSpec.describe "Movie show page" do

  before :each do
    @studio = Studio.create(name: "Funny Studio", location: "Hollywood")
    @movie = @studio.movies.create(title: "Dumb n Dumber", year: "1999", genre: "Comedy")
    @actor1 = @movie.actors.create(name: "Kid Actor", age: 10)
    @actor2 = @movie.actors.create(name: "Middle Age Actor", age: 40)
    @actor3 = @movie.actors.create(name: "Old Actor", age: 70)
  end
  it "user can see movie info and all actors by age" do
    visit "/movies/#{@movie.id}"

    expect(page).to have_content(@movie.title)
    expect(page).to have_content(@movie.year)
    expect(page).to have_content(@movie.genre)

    within ".actors-list" do
      expect(@actor1.name).to appear_before(@actor2.name)
      expect(@actor2.name).to appear_before(@actor3.name)
      expect(page).to have_content("Average Age: 40")
    end
  end

  it "New Actor Form" do
    new_actor = Actor.create(name: "Jim Carrey", age: 33)
    visit "/movies/#{@movie.id}"
    within '.new-actor-form' do
      fill_in :name, with: new_actor.name
      click_button "submit"
    end
    expect(current_path).to eq("/movies/#{@movie.id}")
    expect(page).to have_content(new_actor.name)
  end
end
