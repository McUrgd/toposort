
module Toposort
	class Edge 
		attr_accessor :node_from
		attr_accessor :node_to

		def initialize(node_from,node_to)
			@node_from = node_from
			@node_to = node_to
		end

		def to_s
			puts node_from+" > "+node_to
		end	
	end

	class InputLine
		attr_accessor :vstart
		attr_accessor :vend
		def initialize(line)
			t = line.partition(">").each{|x| x.strip!}
			@vstart = t[0]
			@vend = t[2]
			#если line = "A", то t = ["A", "", ""]
			#если line = "A > B", то t = ["A", ">", "B"]
			raise ArgumentError.new("input error "+line) if (@vstart == "" and line !="") or (t[1] == ">" and @vend == "")
		end
	end

	class Graph 
		attr_accessor :nodes
		attr_accessor :edges

		def initialize(filename)
			@nodes = Array.new
			@edges = Array.new
			File.readlines(filename).each do |line|
				t = InputLine.new(line)
				vstart = t.vstart
				vend = t.vend
				if t.vend != ""
					@nodes << vend if not @nodes.include?(vend)
					@edges << Edge.new(vstart,vend)
				end	
				@nodes << vstart if not @nodes.include?(vstart)	
			end
		end

		def edges_to_hash
			res = Hash.new
			@nodes.each {|node| res[node] = Array.new }
			@edges.each {
				|edge|
				node_from = edge.node_from
				node_to = edge.node_to
				res[node_from] << edge.node_to
			}
			res
		end
	end
end