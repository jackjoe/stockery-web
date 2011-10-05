class PortfolioMailer < ActionMailer::Base

  def notify_creator(port)
    mail(
      :subject  => 'Portfolio created at Stockery Arduino',
      :to       => port.email,
      :from     => 'pieter@noort.be', 
      :tag      => 'creation'
  )
  end
end
