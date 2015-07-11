require_relative "solve.rb"

Dir["./graph/*"].each {
	|filename|
	num = filename.delete("^0-9")
	solution = "./solution/solution"+num+".txt"
	Thread.new {
		begin 
			Solver.new.solve(filename,solution) 
		rescue ArgumentError => e
			puts e.message+" at "+filename
		end
	}.join
}