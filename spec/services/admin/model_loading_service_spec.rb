require "rails_helper"

describe Admin::ModelLoadingService do
  context "when #call" do
    let!(:categories) { create_list(:category, 15) }

    context "when params are present" do
    end

    context "when params are not present" do
    end
  end  
end