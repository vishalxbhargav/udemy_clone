require 'rails_helper'

RSpec.describe Forume, type: :model do
  it{should belong_to(:course)}
  it{should have_many(:questions).dependent(:destroy)}
end
