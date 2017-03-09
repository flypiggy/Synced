class Admin::SponsorsController < Admin::BaseController
  def index
    load_sponsors
  end

  def new
    @sponsor = Sponsor.new
    authorize @sponsor
  end

  def edit
    load_sponsor
  end

  def create
    @sponsor = Sponsor.new(sponsor_params)
    authorize @sponsor
    @sponsor.save
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
    authorize :sponsor
    @sponsors = Sponsor.order(created_at: :desc).page(params[:page]).per(10)
  end

  def load_sponsor
    @sponsor = Sponsor.find(params[:id])
    authorize @sponsor
  end

  def sponsor_params
    params.require(:sponsor).permit(:name, :url, logos_attributes: [:id, :file, :_destroy])
  end
end
