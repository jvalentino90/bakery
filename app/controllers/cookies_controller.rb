
class CookiesController < ApplicationController
  before_action :authenticate_user!
  before_action :sanitize_params, only: :create

  def new
    @oven = current_user.ovens.find_by!(id: params[:oven_id])
    if @oven.cookies.blank?
      @cookie = @oven.cookies.new
    else
      redirect_to @oven, alert: "Number of cookies in the oven: #{@oven.cookies.length})"
    end
  end

  def create
    @oven = current_user.ovens.find_by!(id: params[:oven_id])
    params[:cookies_qty].to_i.times do
      Cookie.create(cookie_params.merge(storage: @oven))
    end
    redirect_to oven_path(@oven)
  end

  def empty
    @oven = current_user.ovens.find(params[:oven_id])
    @cookie = @oven.cookies.find(params[:id])
    if @cookie.ready?
      @cookie.update(storage: current_user)
    end
    redirect_to @oven, alert: 'Oven emptied'
  end

  private

  def cookie_params
    params.require(:cookie).permit(:fillings)
  end

  def sanitize_params
    params[:cookies_qty] = 1 unless params[:cookies_qty].to_i.positive?
  end
end
