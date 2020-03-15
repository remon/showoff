class SessionsController < ApplicationController
  def new
    respond_to do |format|
      format.js { render layout: false } # Add this line to you respond_to block
      format.html
    end
  end

  def destroy
  end

  def create
  end
end
