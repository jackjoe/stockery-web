class PortfoliosController < ApplicationController

  def show
    @port = Portfolio.find_by_name(params[:id])

    unless @port.nil?
      respond_to do |format|
        format.json { render :json => @port.to_json(
          :except => [:id], 
          :include => {
            :stocks => { :only => [:name, :symbol]}
          }
        )}

        format.html do
          @title = "Portfolio '#{@port.name}'"
        end
      end
    else
      redirect_to root_path
    end
  end

  def create
    @port = Portfolio.new(params[:portfolio])

    if @port.save
      redirect_to edit_portfolio_path(@port[:name])
    else
      @title = 'Home'
      
      render 'pages/home'
    end
  end

  def update
    @port = Portfolio.find_by_name(params[:id])
    
    has_stocks = !params[:portfolio][:stocks].nil? && params[:portfolio][:stocks].size > 0

    if has_stocks && @port.update_attributes(params[:portfolio])
      redirect_to portfolio_path(@port.name)
    else
      # TODO I don't want to reset name to name_was ... 
      params[:portfolio][:name] = params[:id]
      @port.name = params[:id]

      render 'edit'
    end 
  end

  def destroy
  end

  def edit
    @title = 'Edit Portfolio'
    
    @port = Portfolio.find_by_name(params[:id])

    @port.stocks.build  
  end

end
