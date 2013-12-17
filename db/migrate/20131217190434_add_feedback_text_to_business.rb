class AddFeedbackTextToBusiness < ActiveRecord::Migration
  def change
  	add_column :businesses ,:feedback_text , :text 	
  end
end
