require 'roodi/checks/cyclomatic_complexity_check'

module Roodi
  module Checks
    class CyclomaticComplexityMethodCheck < CyclomaticComplexityCheck
      def initialize(complexity = 8)
        super(complexity)
      end
      
      def interesting_nodes
        [:method]
      end

      def evaluate(node)
        complexity = count_complexity(node)
        add_error "#{position(node)} - Method name \"#{node.getName}\" has a cyclomatic complexity is #{complexity}.  It should be #{@complexity} or less." unless complexity <= @complexity
      end
    end
  end
end
