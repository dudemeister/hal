class Asset < ActiveRecord::Base
   belongs_to :owner
   belongs_to :mime
   belongs_to :folder   
end
