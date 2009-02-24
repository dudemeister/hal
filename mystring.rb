#
#  Some code found in the web
#

class String
   def xor_slow(other)
     if other.empty?
       self
     else
       a1        = self.unpack("c*")
       a2        = other.unpack("c*")

       a2 *= a1.length/a2.length + 1

       a1.zip(a2).collect{|c1,c2| c1^c2}.pack("c*")
     end
   end

   def xor_fast(other)
     if other.empty?
       self
     else
       if other.length < self.length
         div, mod        = self.length.divmod(other.length)
         other           = other * div + other[0, mod]
       end

       a1        = NArray.to_na(self, "byte")
       a2        = NArray.to_na(other, "byte")

       (a1 ^ a2).to_s
     end
   end   
   
   
   
   # Convert a String to the HEX Representation
   def hex
     self.unpack('U'*self.length).collect {|x| x.to_s 16}.join
   end
   
   def hex2s                            
     s=""
      self.scan(/../).each { | tuple |  s=s+tuple.to_i(16).chr }
      s
   end  
    

   # if narray not installed xor will use the slow version
   begin
     require "narray"

     alias :xor :xor_fast
   rescue LoadError
     if $VERBOSE
       $stderr.puts "I strongly advise to install the library 
'narray'."
     end
     alias :xor :xor_slow
   end
 end

