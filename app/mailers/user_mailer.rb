class UserMailer < ApplicationMailer
  default from: 'wolfpacknationcu@gmail.com'

  def transaction_email(user, transaction)
    @user = user
    @transaction = transaction
    mail(to: @user.email, subject: 'Account Transaction Notification')
  end

end
