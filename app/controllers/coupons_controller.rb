class CouponsController < ApplicationController
  before_action :set_coupon, only: %i[inactivate]

  def inactivate
    @coupon.inactive!
    redirect_to @coupon.promotion
  end

  private

  def set_coupon
    @coupon = Coupon.find(params[:id])
  end
end
