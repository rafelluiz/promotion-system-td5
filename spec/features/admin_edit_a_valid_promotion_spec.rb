require 'rails_helper'

feature 'Admin Edit a valid promotion' do
  scenario 'and attributes cannot be blank' do
    user = User.create!(email: 'user@example.com',password: 'password')

    Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                      code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
                      expiration_date: '22/12/2033',user:user)

    login_as user, scope: :user

    visit root_path
    click_on 'Promoções'
    click_on 'Natal'
    click_on 'Editar'
    fill_in 'Nome', with: ''
    fill_in 'Descrição', with: ''
    fill_in 'Código', with: ''
    fill_in 'Desconto', with: ''
    fill_in 'Quantidade de cupons', with: ''
    fill_in 'Data de término', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Não foi possível criar a promoção')
    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('Código não pode ficar em branco')
    expect(page).to have_content('Desconto não pode ficar em branco')
    expect(page).to have_content('Quantidade de cupons não pode ficar em branco')
    expect(page).to have_content('Data de término não pode ficar em branco')

  end

  scenario 'and code must be unique' do
    user = User.create!(email: 'user@example.com',password: 'password')

    Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                      code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
                      expiration_date: '22/12/2033',user:user)

    Promotion.create!(name: 'Cyber Monday', coupon_quantity: 90,
                      description: 'Promoção de Cyber Monday',
                      code: 'CYBER15', discount_rate: 15,
                      expiration_date: '22/12/2033',user:user)

    login_as user, scope: :user

    visit root_path
    click_on 'Promoções'
    click_on 'Natal'
    click_on 'Editar'
    fill_in 'Código', with: 'CYBER15'
    click_on 'Enviar'

    expect(page).to have_content('Código já está em uso')
  end

  scenario 'edit successfully' do
    user = User.create!(email: 'user@example.com',password: 'password')

    Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                      code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
                      expiration_date: '22/12/2033',user:user)

    login_as user, scope: :user

    visit root_path
    click_on 'Promoções'
    click_on 'Natal'
    click_on 'Editar'

    fill_in 'Nome', with: 'Cyber Monday' # fill_in é o metodo para preencher um INPUT
    fill_in 'Descrição', with: 'Promoção de Cyber Monday'
    fill_in 'Código', with: 'CYBER15'
    fill_in 'Desconto', with: '15'
    fill_in 'Quantidade de cupons', with: '90'
    fill_in 'Data de término', with: '22/12/2033'

    click_on 'Enviar'

    promotion = Promotion.last
    expect(current_path).to eq(promotion_path(promotion))
    expect(page).to have_content('Cyber Monday')
    expect(page).to have_content('Promoção de Cyber Monday')
    expect(page).to have_content('15,00%')
    expect(page).to have_content('CYBER15')
    expect(page).to have_content('22/12/2033')
    expect(page).to have_content('90')

    expect(page).to have_link('Voltar')

  end
end
