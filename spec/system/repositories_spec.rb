# frozen_string_literal: true

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
end
