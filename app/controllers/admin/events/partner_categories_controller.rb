class Admin::Events::PartnerCategoriesController < Admin::BaseController
  def index
    load_event
    @partner_categories = @event.partner_categories
  end

  def create
    load_event
    @partner_category = @event.partner_categories.new(partner_category_params)
    @partner_category.save
    render json: @partner_category
  end

  def update
    load_partner_category
    @partner_category.update(partner_category_params)
  end

  def destroy
    load_partner_category
    @partner_category.destroy
  end

  private

  def partner_category_params
    params.require(:partner_category).permit(:name, :rank_order_position)
  end

  def load_partner_category
    @partner_category = PartnerCategory.find(params[:id])
    authorize :event
  end

  def load_event
    @event = Event.includes(partner_categories: [partner_categories_partners: :partner]).find(params[:event_id])
    authorize :event
  end
end
