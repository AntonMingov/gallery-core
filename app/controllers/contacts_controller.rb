class ContactsController < ApplicationController
  def create
    @contact_form = Contact.new(contact_form_params)

    if @contact_form.save
      Rails.logger.info "New contact form submitted: #{@contact_form.email}"
      redirect_to root_path, notice: t('contacts.success_message')
    else
      Rails.logger.warn "Contact form validation failed: #{@contact_form.errors.full_messages.join(', ')}"
      redirect_to "#{root_url}/#contact", anchor: 'contact', flash: { form_errors: @contact_form.errors.full_messages }
    end
  rescue StandardError => e
    Rails.logger.error "Contact form submission error: #{e.message}"
    redirect_to root_path, alert: t('contacts.error_message', default: 'An error occurred. Please try again.')
  end

  private

  def contact_form_params
    params.require(:contact).permit(:first_name, :last_name, :email, :message)
  end
end
