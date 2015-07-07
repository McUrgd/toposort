@edge = Hash.new
@vertex = Array.new
@cycle_found = "cycle found"

graphFileName = ARGV[0]
solutionFileName = ARGV[1]

if graphFileName.to_s == "" or graphFileName.to_s== ""
	puts "graphFileName not found" if graphFileName.to_s == ""
	puts "solutionFileName not found" if solutionFileName.to_s == ""
	abort
end

#читаем рёбра графа
File.readlines(graphFileName).each do |line|
	temp = line.partition(">")
	vstart = temp[0].strip
	vend = temp[2].strip
	[vstart,vend].each do |x|
		@vertex << x if not @vertex.include?(x)
		@edge[x] = Array.new() if @edge[x]==nil
	end
	@edge[vstart] << vend 
end

#функция, которая проверяет, что cycle действительно является циклом в графе
#предолагается, что cycle начинается и заканчивается одной вершиной
#cycle это String
def verify_cycle(cycle) 
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
	res
end

#функция, которая проверяет, что solution действительно является упорядочиванием графа
#solution это String
def verify_solution(solution) 
	solution = solution.split(" > ").each{ | x | x.strip! }

	for i in 1..solution.length-1 do
		a = solution[i-1]
		b = solution[i]
		if not @edge[a].include?(b) 
			return "no edge from "+a+" to "+b
		end
		for j in 1..i
			if @edge[b].include?(solution[j-1])
				return "edge between "+b+" and "+solution[j-1]
			end
		end
		@vertex.delete(a)
	end
	@vertex.delete(solution[solution.length-1])
	return "not all vertices sorted, remaining "+@vertex.to_s if @vertex.length>0
	return 1
end

solutionFile = File.readlines(solutionFileName)
line = solutionFile[0].chomp

if line == @cycle_found
	res = verify_cycle(solutionFile[1].chomp)
else
	res = verify_solution(line)
end
puts res