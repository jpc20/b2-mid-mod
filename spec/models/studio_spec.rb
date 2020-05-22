require 'rails_helper'

describe Studio, type: :model do
  describe "validations" do
    it {should have_many :movies}
  end
end
