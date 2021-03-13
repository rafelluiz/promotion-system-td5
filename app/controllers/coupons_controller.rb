class CouponsController < ApplicationController
  before_action :set_coupon, only: %i[inactivate]

  def index
    @coupons = Coupon.all
  end

  def search
    @coupons = Coupon.where('code LIKE ?', "%#{params[:q]}%")
    render json: @coupons
  end

  def inactivate
    @coupon.inactive!
    #raise Error if @coupon Entender depois pq isso quebrou
    redirect_to @coupon.promotion
  end

  private

  def set_coupon
    @coupon = Coupon.find(params[:id])
  end
end
