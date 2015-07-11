class Generator

	def generate(vertexCount,outputFileName,cycle)
		
		raise ArgumentError.new("bad vertexCount "+vertexCount.to_s) if not (vertexCount.to_i > 0)
		raise ArgumentError.new("bad outputFileName "+outputFileName.to_s) if outputFileName.to_s == ""

		file = File.new(outputFileName,"w+")
		shuffle = (0...vertexCount).to_a.shuffle!
		(0...vertexCount).each {
			|i|
			found = false
			(0...vertexCount).each {
				|j|
				a = shuffle[i]
				b = shuffle[j]
				#предполагаем, что может прийти cycle вида [5, 1, 7, 0, 4, 2, 3, 6]
				flag1 = (a>b)&&(rand(2) == 1) 
				flag2 = false
				if cycle != nil 
					if cycle.index(a) != nil
						if (cycle[cycle.index(a)+1] == b)
							flag2 = true
						end
					end
				end
				
				if flag1 or flag2
					file.puts "v"+i.to_s+" > "+"v"+j.to_s
					found = true
				end
			}
			file.puts "v"+i.to_s if not found
		}
	end

	def degenerate(vertexCount,outputFileName)
		#count - случайное количество вершин графа
		count = rand(vertexCount)+1
		#представим цикл в виде [0,2,3,4,..,count-1]
		#и смешаем его для использования
		cycle = (0..count).to_a.shuffle!
		generate(vertexCount,outputFileName,cycle)
	end
end

if __FILE__ == $0
	if ARGV[2] == nil
		Generator.new.generate(ARGV[0].to_i,ARGV[1])
	else
		Generator.new.degenerate(ARGV[0].to_i,ARGV[1])
	end
end



