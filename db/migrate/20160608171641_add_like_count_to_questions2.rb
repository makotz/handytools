class AddLikeCountToQuestions2 < ActiveRecord::Migration
  def change
    add_column :questions, :like_count, :integer
  end
end
