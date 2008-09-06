require 'roodi/checks/check'

module Roodi
  module Checks
    class ClassNameCheck < Check
      def interesting_nodes
        [:class]
      end
  
      def evaluate(node)
        pattern = /^[A-Z][a-zA-Z0-9]*$/
        add_error "#{position(node)} - Class name \"#{node[1]}\" should match pattern #{pattern}." unless node[1].to_s =~ pattern
      end
    end
  end
end
