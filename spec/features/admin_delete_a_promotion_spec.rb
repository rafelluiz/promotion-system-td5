require 'rails_helper'

feature 'Admin Delete a Promotion' do
  scenario 'successfully' do
    user = User.create!(email: 'user@example.com',password: 'password')

    Promotion.create!(name: 'Cyber Monday', coupon_quantity: 90,
                      description: 'Promoção de Cyber Monday',
                      code: 'CYBER15', discount_rate: 15,
                      expiration_date: '22/12/2033',user:user)


    login_as user, scope: :user

    visit root_path
    click_on 'Promoções'
    click_on 'Cyber Monday'
    click_on 'Apagar'

    expect(Promotion.count).to eq 0
  end
end
