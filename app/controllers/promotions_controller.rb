class PromotionsController < ApplicationController
  before_action :set_promotion, only: [:show]

  def index
    @promotions = Promotion.all
  end

  def new
    @promotion = Promotion.new
  end

  def create
    @promotion = Promotion.new(promotion_params)

    if @promotion.save
      redirect_to promotion_path(Promotion.last), notice: 'Promotion was successfully created.'
    else
      render :new
    end
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