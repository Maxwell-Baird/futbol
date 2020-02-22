module Compilable

  def find_all_arrays(collection, arg2)
    collection.find_all { |bv| bv.send() == arg2 }
  end

#change collection to be more specific



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
end


# most_accurate_team	Name of the Team with the best ratio of shots to goals for the season
# least_accurate_team	Name of the Team with the worst ratio of shots to goals for the season
