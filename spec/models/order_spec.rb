require 'rails_helper'

RSpec.describe Order, type: :model do
  it{should belong_to(:user)}
  it{should belong_to(:course)}
  it{should validate_presence_of(:transaction_id)}
  it{should define_enum_for(:status).with_values([:failed,:success])}
end
