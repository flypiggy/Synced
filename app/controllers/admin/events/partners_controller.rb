class Admin::Events::PartnersController < Admin::BaseController
  before_action :load_partner_category
  def create
    load_partner
    load_partner_category
    @partner_category.partners << @partner
  end

  def update
    load_partner_categories_partner
    @partner_categories_partner.update(partner_categories_partner_params)
  end

  def destroy
    load_partner
    @partner_category.partners.delete(@partner)
  end

  private

  def partner_categories_partner_params
    params.require(:partner_categories_partner).permit(:rank_order_position)
  end

  def load_partner_categories_partner
    @partner_categories_partner = @partner_category.partner_categories_partners.find_by!(partner_id: params[:id])
  end

  def load_partner_category
    @partner_category = PartnerCategory.find(params[:partner_category_id])
    authorize :event
  end

  def load_partner
    @partner = Partner.find(params[:id])
  end
end
