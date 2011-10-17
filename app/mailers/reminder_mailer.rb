class ReminderMailer < ActionMailer::Base
  def remind_portfolios(email, portfolios)
    @portfolios_list = portfolios

    mail(
      :subject  => 'Your portfolios',
      :to       => email,
      :from     => 'pieter@noort.be', 
      :tag      => 'remind_portfolios'
    )
  end
end
