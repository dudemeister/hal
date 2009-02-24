require 'socket' 
require 'request_handler'

class SearchServer
  attr_accessor :nodeName, :serverSocket
  
  def initialize (nodeName, port = 4567) 
    @nodeName = nodeName
    @serverSocket=TCPServer.new('127.0.0.1', 4567)
  end                                                 
  
  def run
    while(true) 
        while(clientSocket = serverSocket.accept)
          xml=clientSocket.gets
          Thread.start{ 
             rq=RequestHandler.new(@nodeName, xml)  
             clientSocket.puts(rq.response)
          }                                        
      end
    end
  end      
end

                          

  

