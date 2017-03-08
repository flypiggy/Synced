class Admin::SponsorsController < Admin::BaseController
  def index
    load_sponsors
  end

  def new
    @sponsor = Sponsor.new
  end

  def edit
    load_sponsor
  end

  def create
    @sponsor = Sponsor.create(sponsor_params)
  end

  def update
    load_sponsor
    @sponsor.update(sponsor_params)
  end

  def destroy
    load_sponsor
    @sponsor.destroy
  end

  private

  def sponsor_params
    params.require(:sponsor).permit(:name, :url)
  end

  def load_sponsor
    @sponsor = Sponsor.find(params[:id])
  end

  def load_sponsors
    @sponsors = Sponsor.order(created_at: :desc).page(params[:page]).per(10)
  end
end
