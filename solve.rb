require_relative "basic.rb"
include Toposort

class Solver
	def initialize
		@edge = Hash.new
		@vertex_unmarked = Array.new
		@vertex_sorted = Array.new
		@vertex_marked = Array.new
		@cycle_found = "cycle found"
	end

	def solve(input,output) 

		raise ArgumentError.new("input not found") if input.to_s == ""
		raise ArgumentError.new("ouput not found") if output.to_s== ""

		g = Graph.new(input)
		@edge = g.edges_to_hash
		@vertex_unmarked = g.nodes

		while (@vertex_unmarked.length>0) do
			res = visit(@vertex_unmarked.pop)
			break if res == @cycle_found
		end

		file = File.new(output,"w+") 
		if res != @cycle_found
			file.puts @vertex_sorted.reverse.join(" > ")
		else
			last = @vertex_marked.last
			while not @edge[last].include?(@vertex_marked[0])
				@vertex_marked.delete_at(0)
			end
			file.puts res
			file.puts @vertex_marked.join(" > ")
		end

	end

	def visit(vertex)
		res = 1
		return res if @vertex_sorted.include?(vertex)
		if @vertex_marked.include?(vertex)
			@vertex_marked << vertex
			return @cycle_found 
		end	
		@vertex_marked<<vertex

		@edge[vertex].each { |m|
			res = visit(m)
			break if res == @cycle_found
		}
		
		if res != @cycle_found
			@vertex_marked.delete(vertex)
			@vertex_sorted << vertex
		end	
		res
	end
end

if __FILE__ == $0
	Solver.new.solve(ARGV[0],ARGV[1])
end
