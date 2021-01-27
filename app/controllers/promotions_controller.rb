class PromotionsController < ApplicationController
  before_action :set_promotion, only: [:show]

  def index
    @promotions = Promotion.all
  end

  def show; end

  private

  def set_promotion
    @promotion = Promotion.find(params[:id])
  end

  def promotion_params
    params.require(:promotion).permit(:name, :description,:code,:discount_rate,:coupon_quantity,:expiration_date)
  end

end