require "rails_helper"

RSpec.describe "visitor" do
  it "granted access when visiting site root" do
    visit root_path
    expect(current_path).to eq(root_path)
  end

  it "denied access when visiting restricted portion of the site" do
    user = create(:user)
    visit user_path(user)
    expect(current_path).to eq(new_user_session_path)
  end
end
