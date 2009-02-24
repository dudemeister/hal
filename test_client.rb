require 'socket' 
require 'digest/sha1'                 
require 'mystring'
  

class IPSocket
  def portInfo(out = STDOUT)
    out.puts "local:  #{addr[1]}\n" +
      "remote: #{peeraddr[1]}"
  end
end

acces_code=Digest::SHA1.hexdigest("2"+"das salz in der Suppe")
secret_code=Digest::SHA1.hexdigest("HALSECRET"+"das salz in der Suppe") 
path = Digest::SHA1.hexdigest("mp3"+"das salz in der Suppe")     
owner_name = 'user_name'.hex
owner_pass = Digest::SHA1.hexdigest("user_password"+"das salz in der Suppe")  
description = "Der neuste Hit aus den Charts mit unglaublichen Hits aus der Nachbarschaft".hex
file = "testmp3".xor("HALSECRET").hex

xml='<request type="file" action="new" secretkey="'+secret_code+'">'
xml=xml+'<path>'+path+'</path>'
xml=xml+'<file>'+file+'</file>'
xml=xml+'<description>'+description+'</description>'
xml=xml+'<owner_name>'+description+'</owner_name>'
xml=xml+'<owner_pass>'+description+'</owner_pass>'
xml=xml+'<access>'+acces_code+'</access></request>'
clientSocket = TCPSocket.new('localhost', 4567)  
clientSocket.portInfo

clientSocket.puts xml
puts "Antwort: #{clientSocket.gets}"

