class PromotionsController < ApplicationController
  before_action :set_promotion, only: %i[show edit update destroy generate_coupons approve]
  before_action :authenticate_user!

  def index
    @promotions = Promotion.all
  end

  def new
    @promotion = Promotion.new
    @product_categories = ProductCategory.all
  end

  def create
    @promotion = Promotion.new(promotion_params)
    @promotion.user = current_user

    if @promotion.save
      redirect_to @promotion, notice: 'Promotion was successfully created.'
    else
      @product_categories = ProductCategory.all
      render :new ,notice: 'Promotion could not be created.'
    end
  end

  def show; end

  def edit
    @product_categories = ProductCategory.all
  end

  def update
    if @promotion.update(promotion_params)
      redirect_to @promotion, notice: 'Promotion was successfully updated.'
    else
      @product_categories = ProductCategory.all
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

  def approve
    @promotion.approve!(current_user)
    redirect_to @promotion
  end

  private

  def set_promotion
    @promotion = Promotion.find(params[:id])
  end

  def promotion_params
    params.require(:promotion).permit(:name, :description,:code,:discount_rate,:coupon_quantity,
                                      :expiration_date,product_category_ids:[])
  end

end