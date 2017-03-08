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
    @sponsor = Sponsor.new(sponsor_params)
    @sponsor.save
    render :create, layout: false
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

  def load_sponsors
    @sponsors = Sponsor.order(created_at: :desc).page(params[:page]).per(10)
  end

  def load_sponsor
    @sponsor = Sponsor.find(params[:id])
  end

  def sponsor_params
    params.require(:sponsor).permit(:name, :url, logos_attributes: [:id, :file, :_destroy])
  end
end
