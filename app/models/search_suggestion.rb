class SearchSuggestion < ActiveRecord::Base
  attr_accessible :popularity, :term

  def terms_for(prefix)
  	where("term like ?", "#{prefix}_%")
  	suggestions.order("popularity desc").limit(10).pluck(:term)
  	
  end

end
