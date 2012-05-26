class SitesController < ApplicationController
  def new
    @site = Site.new
    @sites = Site.all
  end

  def create
    @site = Site.new params[:site]
    if @site.save
      redirect_to new_site_path
    else
      @sites = Site.all
      render :new
    end
  end
end
