require 'rails_helper'

feature 'User sign in' do
  scenario 'successfully' do
    user = User.create!(email: 'user@example.com',password: 'password')

    visit root_path
    click_on 'Entrar'
    within('form') do
      fill_in 'E-mail',with: user.email
      fill_in 'Senha',with: 'password'
      click_on 'Entrar'
    end

    expect(page).to have_content user.email
    expect(page).to have_content 'Login efetuado com sucesso.'
    expect(page).to have_link 'Sair'
    expect(page).not_to have_link 'Entrar'
  end

  scenario 'and logout' do
    user = User.create!(email: 'user@example.com',password: 'password')

    visit root_path
    click_on 'Entrar'
    within('form') do
      fill_in 'E-mail',with: user.email
      fill_in 'Senha', with: 'password'
      click_on 'Entrar'
    end

    click_on 'Sair'

    within('nav') do
      expect(page).not_to have_link 'Sair'
      expect(page).not_to have_content user.email
      expect(page).to have_link 'Entrar'
    end
  end

  scenario 'and sign up' do
    visit root_path
    click_on 'Entrar'
    click_on 'Sign up'
    within('form') do
      fill_in 'E-mail',with: 'email@example.com'
      fill_in 'Senha',with: 'password'
      fill_in 'Confirme sua senha',with: 'password'
      click_on 'Inscrever-se'
    end

    expect(page).to have_content 'email@example.com'
    expect(page).to have_content 'Bem vindo! Você realizou seu registro com sucesso.'
    expect(page).to have_link 'Sair'
    expect(page).not_to have_link 'Entrar'
  end
end
