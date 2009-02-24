#
#   Simple Config file to make Hal Work
#
require 'digest/sha1'

class AccessCode
  attr_accessor :publicAccess, :nodeAccess, :sharedAcces, :privateAccess
  


  def initialize(publicAccess="2", nodeAccess="3", sharedAccess="5", privateAccess="7")
    @publicAccess=Digest::SHA1.hexdigest(publicAccess+"das salz in der Suppe")  
    @nodeAccess=Digest::SHA1.hexdigest(nodeAccess+"das salz in der Suppe")
    @sharedAccess=Digest::SHA1.hexdigest(sharedAccess+"das salz in der Suppe")  
    @privateAccess=Digest::SHA1.hexdigest(sharedAccess+"das salz in der Suppe")
  end                        
  def is_private_access? access_code
     @privateAccess == access_code
  end                         
  def is_shared_access? access_code
     @sharedAccess == access_code
  end                 
  def is_node_access? access_code
    @nodeAccess == access_code
  end                      
  def is_public_access? access_code
     @publicAccess == access_code
  end  
  def is_valid_access_code? access_code 
    is_public_access? access_code or is_node_access? access_code or is_shared_access? access_code or is_private_access? access_code 
  end
end

class Configuration
attr_accessor :key,  :access_codes  
  def initialize
    @key=Digest::SHA1.hexdigest("HALSECRET"+"das salz in der Suppe")
    @access_codes= AccessCode.new
  end
  
  def is_secret_key? secret_key
    @key==secret_key
  end
end
