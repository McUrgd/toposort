require_relative "generate.rb"

count = ARGV[0].to_i
size = ARGV[1].to_i
for i in (1..count) 
	Thread.new {
		begin 
			Generator.new.generate(size,"./graph/graph"+i.to_s+".txt") 
		rescue ArgumentError => e
			puts e.message+" at "+filename
		end
	}.join
end