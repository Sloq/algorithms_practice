require_relative 'graph'

# Implementing topological sort using both Khan's and Tarian's algorithms

def topological_sort(vertices)
  sorted, queue = [], []

  vertices.each do |vtx|
    queue << vtx if vtx.in_edges.empty?
  end

  until queue.empty?
    next_vtx = queue.shift
    sorted << next_vtx
    #enumerable tracks index so destroy throws
    #off the each method
    until next_vtx.out_edges.empty?
      edge = next_vtx.out_edges.first
      dependent = edge.to_vertex
      edge.destroy!
      if dependent.in_edges.empty?
        queue << dependent
      end
    end
    vertices.delete(next_vtx)
  end
  return [] if vertices.count > 0
  sorted
end


def topological_sort_tarjan(vertices)
  sorted = []
  visited = Hash.new(false)

end
