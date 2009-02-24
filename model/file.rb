class Asset < ActiveRecord::Base
   belongs_to :owner
   belongs_to :mime
   belongs_to :folder             
   
   def add  path, path_hash, file, acces_code, description, owner_name, owner_pass, mime
      path=Folder.find_by_folder_hash(path)
      unless path
        path=Folder.create
        path.folder=path
        path.folder_hash=path_hash
        path.save
      end        
      self.path=path
      self.name=file
      self.acces=acces_code
      self.description=description
      owner=Owner.check(owner_name,owner_pass)
      unless owner
        owner = Owner.create
        owner.name=owner_name
        owner.pasword_hashed
        owner.save
      end
      self.owner=owner
      mime=Mime.find_by_name()
      unless mime
        mime=Mime.create  
        mime.name=mime                 
      end
      self.mime=mime        
   end 
end
