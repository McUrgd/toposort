@edge = Hash.new
@vertex_unmarked = Array.new
@vertex_sorted = Array.new
@vertex_marked = Array.new
@cycle_found = "cycle found"

File.readlines("graph.txt").each do |line|
	t = line.partition(">")
	vstart = t[0].strip
	vend = t[2].strip
	[vstart,vend].each do |x|
		@vertex_unmarked << x if not @vertex_unmarked.include?(x)
		@edge[x] = Array.new() if @edge[x]==nil
	end
	@edge[vstart] << vend 
end

puts @edge
def visit(vertex)
	puts vertex
	puts "@edges "+@edge[vertex].to_s
	puts "@vertex_unmarked "+@vertex_unmarked.to_s
	puts "@vertex_marked "+@vertex_marked.to_s
	puts "@vertex_sorted "+@vertex_sorted.to_s

	return 1 if @vertex_sorted.include?(vertex)
	if @vertex_marked.include?(vertex)
		@vertex_marked << vertex
		return @cycle_found 
	end	
	
	@vertex_marked<<vertex
	res = 1
	@edge[vertex].each do |m|
		res = visit(m)
		break if res == @cycle_found
	end
	if res != @cycle_found
		@vertex_marked.delete(vertex)
		@vertex_sorted << vertex
	end	
	res
end

while (@vertex_unmarked.length>0) do
	res = visit(@vertex_unmarked.pop)
	break if res == @cycle_found
end

if res != @cycle_found
	puts @vertex_sorted.reverse.to_s
else 	
	puts res
	puts @vertex_marked.to_s
end