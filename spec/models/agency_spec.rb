require 'rails_helper'

RSpec.describe Agency, :type => :model do
  context "with no info" do
    it "is invalid" do
      agency = Agency.new
      expect(agency).to be_valid
    end
  end
end
