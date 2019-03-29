class ChangeUserIDinResponse < ActiveRecord::Migration[5.1]
  def change
    rename_column :responses, :user_id, :author_id
  end
end
