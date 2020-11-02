class StartupMailer < ApplicationMailer
  def startup_mail(startup)
    @startup = startup
     mail to: @startup.user.email, subject: "you published startup on bishop"
  end
end
