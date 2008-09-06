module Roodi
  module Core
    class IteratorVisitor
    	def initialize(payload)
      	@payload = payload
    	end
	
    	def visit(visited)
        # puts "Visiting #{visited.class} with value #{visited}"
    		visited.accept(@payload)
    		visitable_nodes = visited.is_language_node? ? visited.sexp_body : visited
    		visitable_nodes.each do |child| 
    		  if child.class == VisitableSexp then
      		  child.filename = visited.filename
      		  child.accept(self)
    		  end
  		  end
    	end
    end
  end
end
