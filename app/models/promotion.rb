class Promotion < ApplicationRecord
  has_secure_token :token, length: 65

  has_one_attached :photo
  has_many :coupons
  has_one :promotion_approval

  has_many :product_category_promototions
  has_many :product_categories, through: :product_category_promototions

  belongs_to :user

  validates :name, :code, :discount_rate, :coupon_quantity, :expiration_date, presence: true
  validates :code, uniqueness: true
  validate :generated_coupons, on: :update


  def generate_coupons!
    codes_coupons = []
    Coupon.transaction do
      (1..coupon_quantity).each do |number|
        codes_coupons << { code: "#{code}-#{'%04d' % number}", created_at:Time.now, updated_at:Time.now }
      end
      coupons.insert_all(codes_coupons)
    end
  end

  def approve!(approval_user)
    PromotionApproval.create(promotion: self, user: approval_user)
  end

  def approved?
    promotion_approval
  end

  def approved_at
    promotion_approval&.approved_at

    return nil unless promotion_approval
    promotion_approval.approved_at
  end

  def approver
    promotion_approval&.user
  end

  private

  def generated_coupons
    if coupons.any?
      errors.add(name,'não pode ser alterado. Pois os cupons já foram gerados.')
    end
  end
end
