class Movie < ActiveRecord::Base
  def self.ratings
   #return find_by_sql"SELECT DISTINCT rating FROM movies" 
    rt = Array.new
    tm = all
    tm.each {|t|
      rt << t[:rating]
    }
    return rt.uniq
    
  end
end
