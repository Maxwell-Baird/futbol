module Compilable

  #working in methods
  def find_by_collection(element, attribute, collection)
    collection.find_all { |bv| bv.send(attribute) == element }
  end

  def total(attribute1, attribute2, collection)
    collection.map { |bv| bv.send(attribute1) + bv.send(attribute2)}
  end

  def round(method)
    method.round(2)
  end

  def count_data(data)

  end

  def averager(object_count, by_object_count)
    round(object_count.to_f / by_object_count)
  end

  def percentage(arg1, arg2, arg3)
    #expected .45% instead of 45%
    round((arg1.length / arg2.to_f))
  end

  def find(arg1, arg2, arg3)
    collection.find { |bv| bv.method == method }
  end
end
