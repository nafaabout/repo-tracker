require 'rails_helper'

RSpec.describe "ManageRepositories", type: :system do
  before do
    driven_by(:rack_test)
  end

  it "Adds a new repository" do
    visit new_repository_path

    fill_in "Repository name:", with: "Microsoft/vscode"

    click_button "Save"

    expect(page).to have_link("Microsoft/vscode")
  end

  it "Displays all repositories in index" do
    repositories = Fabricate.times(3, :repository)
    visit repositories_path

    repositories.each do |repo|
      expect(page).to have_link(repo.full_name)
    end
  end
end
