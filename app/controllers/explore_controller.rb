class ExploreController < ApplicationController
  before_filter :user_loggued, :categories

  def index
  end

  private

  def categories
    get_children = lambda{|category|
      category.children = category.children
      category.children.each do |c|
        get_children(c)
      end
    }
    @categories = @current_user.categories.where(:parent_id => nil)
    @categories.each do |c|
      get_children(c)
    end
  end
end
