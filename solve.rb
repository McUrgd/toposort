@edge = Hash.new
@vertex_unmarked = Array.new
@vertex_sorted = Array.new
@vertex_marked = Array.new
@cycle_found = "cycle found"

input = ARGV[0]
output = ARGV[1]
puts "input not found" if input.to_s == ""
puts "ouput not found" if output.to_s== ""
abort if input.to_s == "" or output.to_s== ""

File.readlines(input).each do |line|
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

file = File.new(output,"w+") 
if res != @cycle_found
	file.puts @vertex_sorted.reverse.join(" > ")
else 	
	file.puts res
	file.puts @vertex_marked.join(" > ")
end