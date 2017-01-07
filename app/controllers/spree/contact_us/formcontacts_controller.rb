class Spree::ContactUs::FormcontactsController < Spree::StoreController

  helper "spree/products"
  def create
    @formcontact = Spree::ContactUs::Formcontact.new(params[:contact_us_formcontact])

    if @formcontact.save
      if Spree::FormContactUs::Config.formcontact_tracking_message.present?
        flash[:formcontact_tracking] = Spree::ContactUs::Config.formcontact_tracking_message
      end
      redirect_to(spree.root_path, :notice => Spree.t('contact_us.notices.success'))
    else
      render :new
    end
  end

  def new
    @formcontact = Spree::ContactUs::Formcontact.new
    @taxonomies = Spree::Taxonomy.includes(root: :children)
  end

  private

  def accurate_title
    Spree.t(:contact_us_title)
  end

end
