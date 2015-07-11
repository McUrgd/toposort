require_relative "verify.rb"

Dir["./graph/*"].each {
	|filename|
	num = filename.delete("^0-9")
	solution = "./solution/solution"+num+".txt"
	Thread.new {
		begin 
			Verifier.new.verify(filename,solution)
		rescue ArgumentError => e
			puts e.message
		end
	}.join
}
