class PromotionsController < ApplicationController
  before_action :set_promotion,:authenticate! , only: %i[show edit update destroy generate_coupons]

  def index
    @promotions = Promotion.all
  end

  def new
    @promotion = Promotion.new
  end

  def create
    @promotion = Promotion.new(promotion_params)

    if @promotion.save
      redirect_to @promotion, notice: 'Promotion was successfully created.'
    else
      render :new ,notice: 'Promotion could not be created.'
    end
  end

  def show; end

  def edit; end

  def update
    if @promotion.update(promotion_params)
      redirect_to @promotion, notice: 'Promotion was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @promotion.destroy

    redirect_to promotions_path
  end

  def generate_coupons
    @promotion.generate_coupons!
    redirect_to @promotion, notice: t('.success')
  end

  private

  def set_promotion
    @promotion = Promotion.find(params[:id])
  end

  def promotion_params
    params.require(:promotion).permit(:name, :description,:code,:discount_rate,:coupon_quantity,:expiration_date)
  end

end