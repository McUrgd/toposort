require_relative "basic.rb"
include Toposort

class Verifier
	def initialize
		@edge = Hash.new
		@vertex = Array.new
		@cycle_found = "cycle found"
	end

	def verify_cycle(cycle) 
		#функция, которая проверяет, что cycle действительно является циклом в графе
		#cycle это String

		res = 1
		vertex = cycle.split(" > ").each{ | x | x.strip! }
		for i in 1..vertex.length-1 do
			a = vertex[i-1]
			b = vertex[i]
			if not @edge[a].include?(b) 
				res = "no edge from "+a+" to "+b
				break
			end
		end
		first = vertex[0]
		last = vertex[vertex.length-1]

		if not @edge[last].include?(first)
			res = "no edge from "+last+" to "+first
		end
		
		res
	end

	def verify_solution(solution) 
		#функция, которая проверяет, что solution действительно является упорядочиванием графа
		#solution это String
		solution = solution.split(" > ").each{ | x | x.strip! }
		solution.each_with_index {
			|currentVertex,i|
			for j in 0..i-1
				precedingVertex = solution[j]
				if @edge[currentVertex].include?(precedingVertex)
					return "edge between "+currentVertex+" and "+precedingVertex
				end
			end
			@vertex.delete(currentVertex)
		}
		return "not all vertices sorted, remaining "+@vertex.to_s if @vertex.length>0
		return 1
	end

	def verify(graphFileName,solutionFileName)
		raise ArgumentError.new("graphFileName not found") if graphFileName.to_s == ""
		raise ArgumentError.new("solutionFileName not found") if solutionFileName.to_s == ""

		#читаем граф
		g = Graph.new(graphFileName)
		@edge = g.edges_to_hash
		@vertex = g.nodes

		solutionFile = File.readlines(solutionFileName)
		line = solutionFile[0].chomp

		if line == @cycle_found
			res = verify_cycle(solutionFile[1].chomp)
		else
			res = verify_solution(line)
		end
			raise ArgumentError.new("bad solution at "+solutionFileName+" for "+graphFileName+" : "+res) if res.to_s != "1"
			puts res
		end
end

if __FILE__ == $0
	Verifier.new.verify(ARGV[0],ARGV[1])
end

