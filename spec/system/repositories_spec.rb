require 'rails_helper'

RSpec.describe 'Repositories Homepage', type: :system do
  before do
    driven_by(:rack_test)
  end

  describe 'Viewing repositories list' do
    it 'Displays all repositories' do
      repositories = Fabricate.times(3, :repository)
      visit repositories_path

      expect(page).to have_text('Repositories')

      repositories.each do |repo|
        expect(page).to have_link(repo.full_name)
      end
    end
  end

  describe 'creating new repository' do
    it 'Adds a new repository' do
      visit repositories_path

      click_on 'Add Repository'

      fill_in 'Repository name:', with: 'Microsoft/vscode'

      click_button 'Save'

      expect(page).to have_link('Microsoft/vscode')
    end
  end

  describe 'show a repository' do
    it 'Shows the Name of the repository' do
      repository = Fabricate(:repository)

      visit repository_path(repository.id)

      expect(page).to have_selector('h2', text: repository.full_name)
    end

    it 'Shows the list of commits'

    it 'Shows the list of issues'

    it 'Shows the list of discussions'
  end
end
