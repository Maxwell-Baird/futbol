module Compilable

  def find_by_collection(element, attribute, collection)
    collection.find_all { |bv| bv.send(attribute) == element }
  end



#change collection to be more specif

  def total(collection, arg2, arg3: nil)
    collection.sum { |bv| arg2 }
  end

  def average(arg1, arg2)
      arg1.to_f / arg2
  end


  def percentage(arg1: nil, arg2: nil, arg3: nil)
    ((arg1.length / arg2.to_f) * 100).round(2)
  end

  def find(arg1: nil, arg2: nil, arg3: nil)
    collection.find { |bv| bv.method == method }
  end


  #different module

  def round(method)
    method.round(2)
  end

    
end
