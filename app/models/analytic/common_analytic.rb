module CommonAnalytic

   def extract_from_list list,property
     self.list.map{|eachinstance| eachinstance.send(property)}
   end

end