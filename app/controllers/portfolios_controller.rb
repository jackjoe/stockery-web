class PortfoliosController < ApplicationController

  def show
    @port = Portfolio.find_by_url(params[:id])

    unless @port.nil?
      respond_to do |format|
        format.json { render :json => @port.to_json(
          :methods => :average, 
          :except => [:id, :url], 
          :include => {
            :stocks => { :only => [:name, :symbol]}
          }
        )}

        format.html do
          @title = "Portfolio '#{@port.name}'"
        end
      end
    else
      redirect_to root_path, :notice => 'The portfolio you requested did not exist.'
    end
  end

  def create
    @port = Portfolio.new(params[:portfolio])

    if @port.save
      PortfolioMailer.notify_creator(@port, edit_portfolio_url(@port.url)).deliver

      redirect_to edit_portfolio_path(@port.url), :success => 'Portfolio created with success.'
    else
      @title = 'Home'

      errors = ''
      
      @port.errors.messages.each { |key, message| errors += "#{key.capitalize} #{message[0]}" }

      flash.now[:error] = "Error creating the portfolio. #{errors}"
      
      render 'pages/home'
    end
  end

  def update
    @port = Portfolio.find_by_url(params[:id])

    if has_stocks?(params[:portfolio][:stocks])
      stocks = []

      params[:portfolio][:stocks].each do |stock|
        stocks << stock unless stock[:symbol].blank?
      end

      params[:portfolio][:stocks] = stocks
    end

    if has_stocks?(params[:portfolio][:stocks]) && @port.update_attributes(params[:portfolio])
      redirect_to portfolio_path(@port.url), :success => 'Portfolio updated with success.'
    else
      # TODO I don't want to reset name to name_was ... 
      params[:portfolio][:name] = params[:id]
      @port.name = params[:id]

      flash.now[:error] = 'Error updating the portfolio.'

      render 'edit'
    end 
  end

  def destroy
  end

  def edit
    @title = 'Edit Portfolio'
    
    @port = Portfolio.find_by_url(params[:id])
    @port.stocks.build  
  end

  private

    def has_stocks?(stocks)
      !stocks.nil? && stocks.size > 0
    end

end
