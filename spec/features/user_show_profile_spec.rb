require "rails_helper"

RSpec.describe "user profile" do
  before(:example) do
    @user = create(:user)
    signin(@user)
  end

  it "shows user information" do
    expect(page).to have_selector("#username", text: @user.username)
    expect(page).to have_selector("#email", text: @user.email)
    expect(page).to have_selector("#biography", text: @user.biography)
  end
end
