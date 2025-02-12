require 'rails_helper'

RSpec.describe Progre, type: :model do
  it{should belong_to(:enrollment)}
  it{should belong_to(:chapter)}
end
