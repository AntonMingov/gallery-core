class TestimonialsController < InheritedResources::Base
  private

  def testimonial_params
    params.require(:testimonial).permit(:title, :title_en, :description, :description_en, :is_authorised, :image)
  end
end
