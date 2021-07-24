require 'rails_helper'

RSpec.describe "AddRepositories", type: :system do
  before do
    driven_by(:rack_test)
  end

  it "Adds a new repository" do
    visit new_repository_path

    fill_in "Repository name:", with: "Microsoft/vscode"

    click_button "Save"
    expect(page).to have_text("Microsoft/vscode")
  end
end
