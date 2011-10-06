class PortfolioMailer < ActionMailer::Base
  def notify_creator(port, port_edit_url)
    @port_edit_url = port_edit_url
    @port = port

    mail(
      :subject  => 'Portfolio created at Stockery Arduino',
      :to       => port.email,
      :from     => 'pieter@noort.be', 
      :tag      => 'creation'
    )
  end
end
