require_relative 'helpers'
require 'rails_helper'
require 'capybara'

describe 'Katas' do
  context 'when is non-user or normal user' do
    before(:each) do
      log_in_user
    end

    it 'can be visited' do
      title = 'First Kata'
      description = 'Description for First Kata'
      kata = Kata.new(
        title: title,
        description: description
      )
      kata.save

      visit katas_path
      click_on(title)

      expect(page).to have_content(title)
      expect(page).to have_content(description)
    end

    it 'cannot add a new kata' do

      visit katas_path

      expect(page).to have_content('Kata-logue')
      expect(page).not_to have_content('add_kata')
    end

    it 'cannot edit or delete katas' do
      kata = Kata.new(
        title: 'First Kata',
        description: 'Description for First Kata'
      )
      kata.save

      visit katas_path

      expect(page).to have_content('Kata-logue')
      expect(page).not_to have_content('edit')
      expect(page).not_to have_content('delete')
    end
  end

  context 'when user is logged as admin' do
    before(:each) do
      log_in_admin
    end

    it 'can be created' do
      title = 'New Kata'
      description = 'Description for New Kata'

      visit katas_path
      click_on('Add Kata')
      fill_in(:kata_title, with: title)
      fill_in(:kata_description, with: description)
      click_on('Save')

      expect(page).to have_content(title)
      expect(page).to have_content(description)
    end

    it 'can be edited' do
      edited_title = 'Edited Kata'
      edited_description = 'Description for Edited Kata'
      kata = Kata.new(
        title: 'Editable Kata',
        description: 'This kata should be edited'
      )
      kata.save

      visit katas_path
      click_on('mode_edit')
      fill_in(:kata_title, with: edited_title)
      fill_in(:kata_description, with: edited_description)
      click_on('Save')

      expect(page).to have_content(edited_title)
      expect(page).to have_content(edited_description)
    end

    it 'can de deleted' do
      title = 'Deleteable Kata'
      description = 'This kata should be deleted'
      kata = Kata.new(
        title: title,
        description: description
      )
      kata.save

      visit katas_path
      click_on('delete')

      expect(page).not_to have_content(title)
      expect(page).not_to have_content(description)
    end

    it 'shows errors when create an empty kata' do

      visit root_path
      click_on(add_kata_button)
      click_on(save_button)

      expect(page).to have_content(title_error_message)
      expect(page).to have_content(description_error_message)
    end

    it 'shows errors when edit an empty kata' do
      kata = Kata.new(
        title: 'Any',
        description: 'Any'
      )
      kata.save

      visit root_path
      click_on('mode_edit')
      fill_in(:kata_title, with: '')
      fill_in(:kata_description, with: '')
      click_on(save_button)

      expect(page).to have_content(title_error_message)
      expect(page).to have_content(description_error_message)
    end

    def save_button
      I18n.t(:save)
    end

    def add_kata_button
      I18n.t(:add_kata)
    end

    def title_error_message
      I18n.t(:empty_title)
    end

    def description_error_message
      I18n.t(:empty_description)
    end
  end
end
