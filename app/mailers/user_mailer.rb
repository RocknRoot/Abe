class UserMailer < ActionMailer::Base
  default from: "no-reply@rocknroot.org"

  def password_reset(user)
    @user = user
    mail :to => user.email, :subject => "[Abe] Password reset"
  end
end
