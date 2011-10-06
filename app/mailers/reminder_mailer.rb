class ReminderMailer < ActionMailer::Base
  def remind_portfolios(email, portfolios, host)
    @portfolios = portfolios
    @host = host

    mail(
      :subject  => 'Your portfolios',
      :to       => email,
      :from     => 'pieter@noort.be', 
      :tag      => 'remind_portfolios'
    )
  end
end
