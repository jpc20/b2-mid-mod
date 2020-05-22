require 'rails_helper'

RSpec.describe "Actor show page" do

  before :each do
    @studio = Studio.create(name: "Funny Studio", location: "Hollywood")
    @movie = @studio.movies.create(title: "Dumb n Dumber", year: "1999", genre: "Comedy")
    @movie2 = @studio.movies.create(title: "Fake Move", year: "1999", genre: "Comedy")
    @actor1 = @movie.actors.create(name: "Kid Actor", age: 10)
    @actor2 = @movie.actors.create(name: "Middle Age Actor", age: 40)
    @actor3 = @movie.actors.create(name: "Old Actor", age: 70)
    @actor4 = @movie2.actors.create(name: "Fake Actor", age: 70)
  end

  it "User can see actor name, age, actors they have worked with" do
    visit "/actors/#{@actor1.id}"
    expect(page).to have_content(@actor1.name)
    expect(page).to have_content(@actor1.age)
    within ".actors-worked-with" do
      expect(page).to have_content(@actor2.name)
      expect(page).to have_content(@actor3.name)
      expect(page).to_not have_content(@actor4.name)
    end
  end

end
