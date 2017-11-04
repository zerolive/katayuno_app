require 'rails_helper'
require 'capybara'

describe 'Katas' do
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

  it 'can be created' do
    title = 'New Kata'
    description = 'Description for New Kata'

    visit katas_path
    click_on(:add_kata)
    fill_in(:kata_title, with: title)
    fill_in(:kata_description, with: description)
    click_on(:save)

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
    click_on(:edit)
    fill_in(:kata_title, with: edited_title)
    fill_in(:kata_description, with: edited_description)
    click_on(:save)

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
    click_on(:delete)

    expect(page).not_to have_content(title)
    expect(page).not_to have_content(description)
  end
end
