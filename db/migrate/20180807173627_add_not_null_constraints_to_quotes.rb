class AddNotNullConstraintsToQuotes < ActiveRecord::Migration[5.2]
  def change
    change_column_null :quotes, :content, false 
    change_column_null :quotes, :author, false 
  end
end
