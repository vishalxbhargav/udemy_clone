require 'rails_helper'

RSpec.describe Answer, type: :model do
  it{should belong_to(:question)}
  it{should have_many(:comments).dependent(:destroy)}
end
