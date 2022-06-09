class Public::ContactsController < ApplicationController
  def index
    @contact = Contact.new
  end

  def confirm
    @contact = Contact.new(contact_params)
    if @contact.invalid?
      render "new"
    else
      render "confirm"
    end
  end
  
  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      ContactMailer.send_mail(@contact).deliver_now
      render "thanks"
    else
      render :new
    end
  end

  def thanks
    @contact = Contact.new(params[:inquiry].permit(:name, :email, :subject, :message))    
    InquiryMailer.received_email(@inquiry).deliver

    # 完了画面を表示
    render :action => 'thanks'
  end
  
  private

  def contact_params
    params.permit(:name, :email, :subject, :message)
  end
  
end
