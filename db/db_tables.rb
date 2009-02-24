require 'rubygems'
require 'sqlite3'
require 'active_record' 
require '../model/file.rb'
require '../model/owner.rb'
require '../model/mime.rb'
require '../model/folder.rb'
require '../model/index.rb'


# connect to database.  This will create one if it doesn't exist
MY_DB_NAME = "hal.brain.db"
MY_DB = SQLite3::Database.new(MY_DB_NAME)

# get active record set up
ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', :database => MY_DB_NAME)

if !Asset.table_exists?
  ActiveRecord::Base.connection.create_table(:assets) do  |table|
    table.column :name, :string
    table.column :description, :text
    table.column :folder_id, :integer
    table.column :mime_id, :integer
    table.column :owner_id, :integer
    table.column :access, :integer   
  end 
end

if !Owner.table_exists?                                                              
  ActiveRecord::Base.connection.create_table(:owners) do  |table|
    table.column :name, :string
    table.column :password_hassed, :string
  end   
end
if !Mime.table_exists?
  ActiveRecord::Base.connection.create_table(:mimes) do  |table|
    table.column :name, :string
  end
end

if !Folder.table_exists?
  ActiveRecord::Base.connection.create_table(:folders) do  |table|
    table.column :folder, :string
    table.column :folder_hash, :string
  end      
end

if !Index.table_exists?
  ActiveRecord::Base.connection.create_table(:indexes) do   |table|
    table.column :hash_value, :string
    table.column :file_id, :string
  end
end