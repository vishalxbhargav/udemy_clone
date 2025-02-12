require 'rails_helper'

RSpec.describe Verifycation, type: :model do
  it{should belong_to(:course)}
end
