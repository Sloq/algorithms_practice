# Given an Array of tuples, where tuple[0] represents a package id,
# and tuple[1] represents its dependency, determine the order in which
# the packages should be installed. Only packages that have dependencies
# will be listed, but all packages from 1..max_id exist.

# N.B. this is how `npm` works.

# Import any files you need to



def install_order(arr)
  max = 0
  vertices = {}
  arr.each do |tuple|
    #create the graph
    vertices[touple[0]] = Vertex.new(touple[0]) unless vertices[tuple[0]]
    vertices[tuple[1]] = Vertex.new(tuple[1]) unless vertices[tuple[1]]

    #reset max if needed
    max = tuple.max if tuple.max > max
  end

  #find the missing packages
  independent = []
  (1..max).each do |i|
    independent << i unless vertices[i]
  end
  #sort the vertices of the graph and add the missing packages
  independent + topolocical_sort(vertices.values).map { |v| v.value }
end

def install_order_two(arr)
  vertices = {}
  arr.each do |tuple|
    dependent = tuple[0]
    dependency = tuple[1]

    vertices[dependent] = Vertex.new(dependent) unless vertices[dependent]
    vertices[dependency] = Vertex.new(dependency) if dependency && !vertices[dependency]
    Edge.new(vertices[dependency], vertices[dependent]) if dependency
  end
  topological_sort(vertices.values).map { |v| v.value }
end

def install_order2(arr)
  vertices = {}
  arr.each do |tuple|
    dependent = tuple[0]
    dependency = tuple[1]

    vertices[dependent] = Vertex.new(dependent) unless vertices[dependent]
    vertices[dependency] = Vertex.new(dependency) if dependency && !vertices[dependency]
    Edge.new(vertices[dependency], vertices[dependent]) if dependency
  end

  topological_sort(vertices.values).map { |v| v.value }
end
