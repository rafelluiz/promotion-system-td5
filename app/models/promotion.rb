class Promotion < ApplicationRecord
  has_many :coupons
  belongs_to :user

  validates :name, :code, :discount_rate, :coupon_quantity, :expiration_date, presence: true
  validates :code, uniqueness: true
  validate :generated_coupons, on: :update


  def generate_coupons!
    codes_coupons = []
    Coupon.transaction do
      (1..coupon_quantity).each do |number|
        codes_coupons << {code: "#{code}-#{'%04d' % number}", created_at:Time.now, updated_at:Time.now}
      end
      coupons.insert_all(codes_coupons)
    end
  end

  private

  def generated_coupons
    if coupons.any?
      errors.add(name,'não pode ser alterado. Pois os cupons já foram gerados.')
    end
  end

end
