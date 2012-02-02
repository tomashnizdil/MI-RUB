class Array
  def vypis
    self.each_index { |i| # vypis
      print self[i]
      if (i==self.size-1)
        print "\n"
      else 
        print " "
      end
    }
  end
end

class Vertex
  attr_reader :name, :adjacentVertices
  attr_accessor :state
  def initialize(name)
    @name = name
    @adjacentVertices = []
    @adjacentVerticesCount = 0
    @state = :fresh
  end
  
  def add_adjacent_vertex(vertex)
    @adjacentVertices[@adjacentVerticesCount] = vertex
    @adjacentVerticesCount += 1
  end
end

class Graph
  def initialize
    @verticesCount = gets.to_i
    @vertices = Array.new(@verticesCount)
    
    for i in 0..@verticesCount-1  # indexuju od 0, takze na pozici i je uzel se jmenem (i+1)
      @vertices[i] = Vertex.new(i+1)
    end
    @vertices.each { |vertex| check_edges }
    check_queries
  end
  
  def check_edges
    array = gets.split(' ')
    for i in 2..array[1].to_i+1
      @vertices[array[0].to_i-1].add_adjacent_vertex(@vertices[array[i].to_i-1])
    end
  end
  
  def check_queries
    while 1 > 0
      line = gets
      query = line.split(' ')
      break if (query[0].to_i == 0 and query[1].to_i == 0)
      if query[1].to_i == 0 # query[1] ~ method
        dfs(@vertices[query[0].to_i-1]) # query[0] ~ starting_vertex
      else
        bfs([@vertices[query[0].to_i-1]])
      end
    end
  end
  def dfs(vertex)
    @vertices.each { |vertex| vertex.state = :fresh }
    dfs_array = []
    dfs_search(dfs_array, vertex)
    dfs_array.vypis
  end
  def dfs_search(bfs_array, vertex)
    bfs_array.push(vertex.name)
    vertex.state = :closed
    vertex.adjacentVertices.each { |av| 
      if av.state.eql?(:fresh)
          dfs_search(bfs_array, av)
      end
    }
  end
  
  def bfs(next_level)
    @vertices.each { |vertex| vertex.state = :fresh }
    bfs_array = []
    until (next_level.empty? or bfs_array.size == @verticesCount)
      open = []
      next_level.each { |vertex| 
        if vertex.state.eql?(:fresh)
          bfs_array.push(vertex.name)
          vertex.adjacentVertices.each { |av| open.push(av) }
          vertex.state = :closed
        end
      }
      next_level = open
    end
    bfs_array.vypis
  end
end

class Program
  def initialize
    @graphsCount = gets.to_i
    @graphs = Array.new(@graphsCount)
    
    for i in 0..@graphsCount-1
      puts "graph #{i+1}"
      @graphs[i] = Graph.new
    end
  end
end

Program.new