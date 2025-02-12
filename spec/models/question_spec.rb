require 'rails_helper'

RSpec.describe Question, type: :model do
  it{should belong_to(:forume)}
  it{should have_many(:answers).dependent(:destroy)}
end
