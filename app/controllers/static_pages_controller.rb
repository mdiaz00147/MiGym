class StaticPagesController < ApplicationController
  def setup
    @base_title = "Ruby on Rails Tutorial Sample App"
  end
  def home
  end

  def help
  end
  def contact
  	@contact_user = User.where(admin:1).first
  end
end
