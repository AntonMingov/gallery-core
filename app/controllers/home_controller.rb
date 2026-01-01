class HomeController < ApplicationController
  def index
    @testimonials = Testimonial.authorised
                               .with_attached_image
                               .order(Arel.sql('RANDOM()'))
    @contact_form = Contact.new
    @friends = Friend.authorised.with_attached_image
    @categories = Category.authorised.with_attached_image
  end
end
