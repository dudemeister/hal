
require 'mystring'  

require 'rubygems'
require 'sqlite3'
require 'active_record'

require 'model/file.rb'
require 'model/owner.rb'
require 'model/mime.rb'
require 'model/folder.rb'
require 'model/index.rb'
require 'config'

                                                     
class RequestHandler
   
  attr_accessor :response
  
  def initialize (nodeName, request)
    @nodeName=nodeName
    @request=request
    @config = Configuration.new
    handle_request 
  end            

       
  def handle_request  
    request_array = XmlSimple.xml_in(@request) 
    if request_array['type']=='file' 
       file_handler request_array
    end                          
    if request_array['type']=='search'
    end
  end     
  
  def search_handler request_array
    
  end  
  
  def file_handler request_array
    if @config.is_secret_key? request_array['secretkey']   
      access_codes=@config.access_codes
      if access_codes.is_valid_access_code? request_array['access'].to_s
        acces_code=request_array['access'].to_s            
        path=request_array['path'].to_s
        name=request_array['file'].to_s.hex2s.xor("HALSECRET")                   
        description=request_array['description'].to_s.hex2s   
        owner_pass = request_array['owner_pass']
        owner_name = request_array['owner_name'].to_s.hex2s
          Thread.new{    
            unless request_array['action']=='delete'
              asset=Asset.create if request_array['action']=='new' 
              asset=Asset.find_by_name(name) if request_array['action']=='update'  
              asset.add path, file, acces_code, description, owner_name, owner_pass
              asset.save                              
            else                                     
              asset.Asset.find_by_name(name)
              asset.delete owner_name, owner_pass
            end                                                       
          }                                
        @response = "200"                  
      else   
        @response = "300" 
      end
    else
      @response = "100"
    end   
    p @response
  end
  
end                   
