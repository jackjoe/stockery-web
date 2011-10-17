class ReminderController < ApplicationController

  def thanks
    @email = params[:email]
  end

  def create
    ports = Portfolio.find_all_by_email(params[:email])

    unless ports.nil? || ports.size == 0
      portfolios = []

      ports.each do |port|
        portfolios << {:name => port.name, :link => edit_portfolio_url(port.url, :host => request.host)} unless port.url.blank?
      end

      ReminderMailer.remind_portfolios(params[:email], portfolios).deliver

      redirect_to reminder_thanks_path(:email => params[:email]), :success => "Your portfolio info was mailed to #{params[:email]}"
    else
      redirect_to root_path, :notice => 'E-mail address was not found'  
    end
  end

end
