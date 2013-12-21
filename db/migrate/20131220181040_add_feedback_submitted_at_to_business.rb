class AddFeedbackSubmittedAtToBusiness < ActiveRecord::Migration
  def change
  	  add_column :businesses ,:feedback_submited_at , :datetime 	
  end
end
